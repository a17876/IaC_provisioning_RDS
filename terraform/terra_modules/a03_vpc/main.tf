# Create a VPC
resource "aws_vpc" "a03_vpc" {
  cidr_block           = var.base_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "a03_vpc"
  }
}

# Create a backend subnet
resource "aws_subnet" "a03_be_subnet" {
  vpc_id                  = aws_vpc.a03_vpc.id
  cidr_block              = var.sub_be_cidr_block
  availability_zone            = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "a03_be_subnet"
  }
}

# Create a web subnet
resource "aws_subnet" "a03_web_subnet" {
  vpc_id                  = aws_vpc.a03_vpc.id
  cidr_block              = var.sub_web_cidr_block
  availability_zone            = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "a03_web_subnet"
  }
}

# Create a db_1 subnet
resource "aws_subnet" "a03_db_1_subnet" {
  vpc_id                  = aws_vpc.a03_vpc.id
  cidr_block              = var.sub_db_1_cidr_block
  availability_zone            = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "a03_db_1_subnet"
  }
}

# Create a db_2 subnet
resource "aws_subnet" "a03_db_2_subnet" {
  vpc_id                  = aws_vpc.a03_vpc.id
  cidr_block              = var.sub_db_2_cidr_block
  availability_zone            = "us-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "a03_db_2_subnet"
  }
}


# Create an internet gateway
resource "aws_internet_gateway" "a03_gw" {
  vpc_id = aws_vpc.a03_vpc.id

  tags = {
    Name = "a03_gw"
  }
}

# Create a route table
resource "aws_route_table" "a03_route" {
  vpc_id = aws_vpc.a03_vpc.id
  
  tags = {
    Name = "a03_route"
  }
}

# add route to route table
resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.a03_route.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.a03_gw.id
}

# associate the route table with be subnet
resource "aws_route_table_association" "a03_be" {
  subnet_id      = aws_subnet.a03_be_subnet.id
  route_table_id = aws_route_table.a03_route.id
}

# associate the route table with web subnet
resource "aws_route_table_association" "a03_web" {
  subnet_id      = aws_subnet.a03_web_subnet.id
  route_table_id = aws_route_table.a03_route.id
}

# associate the route table with db_1 subnet
resource "aws_route_table_association" "a03_db_1" {
  subnet_id      = aws_subnet.a03_db_1_subnet.id
  route_table_id = aws_route_table.a03_route.id
}

# associate the route table with db_2 subnet
resource "aws_route_table_association" "a03_db_2" {
  subnet_id      = aws_subnet.a03_db_2_subnet.id
  route_table_id = aws_route_table.a03_route.id
}

output "a03_vpc_id" {
  value = aws_vpc.a03_vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.a03_vpc.cidr_block
}

output "a03_be_subnet_id" {
  value = aws_subnet.a03_be_subnet.id
}

output "a03_web_subnet_id" {
  value = aws_subnet.a03_web_subnet.id
}

output "a03_db_1_subnet_id" {
  value = aws_subnet.a03_db_1_subnet.id
}
output "a03_db_2_subnet_id" {
  value = aws_subnet.a03_db_2_subnet.id
}


# write data to file when resources are created
# file will be managed with terraform, deleted with resources are destroyed
resource "local_file" "vpc_vars_file" {
  content       = <<-eof
    a03_vpc: ${aws_vpc.a03_vpc.id}
    vpc_cidr_block: ${aws_vpc.a03_vpc.cidr_block}
    a03_be_subnet: ${aws_subnet.a03_be_subnet.id}
    a03_web_subnet: ${aws_subnet.a03_web_subnet.id}
  eof
  file_permission = "0640"
  filename         = "vars.yaml"
}
