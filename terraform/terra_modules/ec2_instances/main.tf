# use an existing key pair on host machine with file func
resource "aws_key_pair" "local_key" {
  key_name = "terra"
  public_key = file(var.pub_key_path)
}

# get the most recent ami for Ubuntu 23.04
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-lunar-23.04-amd64-server-*"]
  }
}

## Create EC2 instance that uses the latest ubuntu ami from data the local key above
# Create a02_backend_ec2 instance
resource "aws_instance" "a03_be_ec2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.local_key.id
  vpc_security_group_ids = [var.a03_be_sg_id]
  subnet_id              = var.a03_be_subnet_id     

  tags = {
    Name = "a03_be_ec2"
  }
}

# Create a02_web_ec2 instance
resource "aws_instance" "a03_web_ec2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.local_key.id
  vpc_security_group_ids = [var.a03_web_sg_id]
  subnet_id              = var.a03_web_subnet_id

  tags = {
    Name = "a03_web_ec2"
  }
}

# write data to file when resources are created
# file will be managed with terraform, deleted with resources are destroyed
resource "local_file" "vpc_vars_file" {
  content       = <<-eof
    a03_be_ec2: ${aws_instance.a03_be_ec2.id}
    a03_web_ec2: ${aws_instance.a03_web_ec2.id}
  eof
  file_permission = "0640"
  filename         = "vars.yaml"
}