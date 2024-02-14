# Security group for backend ec2 instance
resource "aws_security_group" "a03_be_sg" {
  name        = "allow-ssh"
  description = "allow ssh from home and work"
  vpc_id      = var.a03_vpc_id

  tags = {
    Name = "a03_be_sg"
  }
} 

# Security group for web ec2 instance
resource "aws_security_group" "a03_web_sg" {
  name        = "allow-ssh-http"
  description = "allow ssh from home and work / http from anywhere"
  vpc_id      = var.a03_vpc_id

  tags = {
    Name = "a03_web_sg"
  }
}

# Security group for db_1 ec2 instance
resource "aws_security_group" "a03_db_1_sg" {
  name        = "allow-port-3306"
  description = "allow port 3306 from be subnet"
  vpc_id      = var.a03_vpc_id

  tags = {
    Name = "a03_db_1_sg"
  }
}



## Ingress rules for backend ec2 instance security group
# allow ssh from home
resource "aws_vpc_security_group_ingress_rule" "a03_be_ssh_home" {
  security_group_id = aws_security_group.a03_be_sg.id

  cidr_ipv4   = var.home_cidr_block
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

# allow ssh from bcit
resource "aws_vpc_security_group_ingress_rule" "a03_be_ssh_bcit" {
  security_group_id = aws_security_group.a03_be_sg.id

  cidr_ipv4   = var.bcit_cidr_block
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

# # allow all traffic from a03_be_sg security group
resource "aws_vpc_security_group_ingress_rule" "a03_be_all_vpc" {
  security_group_id = aws_security_group.a03_be_sg.id

  cidr_ipv4   = var.base_cidr_block
  ip_protocol = -1
}


## Ingress rules for web ec2 instance security group
# allow all traffic dest port 80 from anywhere
resource "aws_vpc_security_group_ingress_rule" "a03_web_http" {
  security_group_id = aws_security_group.a03_web_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

# allow all traffic dest port 443 from anywhere
resource "aws_vpc_security_group_ingress_rule" "a03_web_https" {
  security_group_id = aws_security_group.a03_web_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

# allow ssh from home
resource "aws_vpc_security_group_ingress_rule" "a03_web_ssh_home" {
  security_group_id = aws_security_group.a03_web_sg.id

  cidr_ipv4   = var.home_cidr_block
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

# allow ssh from bcit
resource "aws_vpc_security_group_ingress_rule" "a03_web_ssh_bcit" {
  security_group_id = aws_security_group.a03_web_sg.id

  cidr_ipv4   =  var.bcit_cidr_block
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

# allow all traffic from a03_be_sg security group
resource "aws_vpc_security_group_ingress_rule" "a03_web_from_be" {
  security_group_id = aws_security_group.a03_web_sg.id

  cidr_ipv4   = var.sub_be_cidr_block
  ip_protocol = -1
}

## Ingress rules for db_1 ec2 instance security group
# allow all traffic dest port 3306 from be subnet
resource "aws_vpc_security_group_ingress_rule" "a03_db_1_port" {
  security_group_id = aws_security_group.a03_db_1_sg.id

  cidr_ipv4   = var.sub_be_cidr_block
  from_port   = 3306
  ip_protocol = "tcp"
  to_port     = 3306
}


## Egress rule for backend ec2 instance security group
# any destination and protocol
resource "aws_vpc_security_group_egress_rule" "a03_be_egress" {
  security_group_id = aws_security_group.a03_be_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}


## Egress rule for web ec2 instance security group
# any destination and protocol
resource "aws_vpc_security_group_egress_rule" "a03_web_egress" {
  security_group_id = aws_security_group.a03_web_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}

## Egress rule for db ec2 instance security group
# any destination and protocol
resource "aws_vpc_security_group_egress_rule" "a03_db_1_egress" {
  security_group_id = aws_security_group.a03_db_1_sg.id

  cidr_ipv4   = var.sub_be_cidr_block
  from_port   = 3306
  ip_protocol = "tcp"
  to_port     = 3306
}

output "a03_db_1_sg_id" {
  value = aws_security_group.a03_db_1_sg.id
}

output "a03_web_sg_id" {
  value = aws_security_group.a03_web_sg.id
}

output "a03_be_sg_id" {
  value = aws_security_group.a03_be_sg.id
}


# write data to file when resources are created
# file will be managed with terraform, deleted with resources are destroyed
resource "local_file" "vpc_vars_file" {
  content       = <<-eof
    a03_db_1_sg: ${aws_security_group.a03_db_1_sg.id}
  eof
  file_permission = "0640"
  filename         = "vars.yaml"
}