# create the subnet group for the rds instance
resource "aws_db_subnet_group" "database_subnet_group" {
   name        = "rds_subnet_group"
   subnet_ids  = [var.a03_db_1_subnet_id, var.a03_db_2_subnet_id]
   description = "Subnet group for RDS database"
   tags = {
     Name = "database_subnet_group"
   }
}



# create the rds instance
resource "aws_db_instance" "a03_db_1_rds" {
  engine                 = "mysql"
  engine_version         = "8.0.34"
  multi_az               = false
  identifier             = "rds-database-instance"
  username               = var.db_username
  password               = var.db_password
  instance_class         = "db.t2.micro"
  allocated_storage      = 5
  db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids = [var.a03_db_1_sg_id]
  availability_zone      = "us-west-2a"
  db_name                = "a03rds"
  skip_final_snapshot    = true
}

# outputs for RDS instance info
output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.a03_db_1_rds.address
  sensitive   = true
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.a03_db_1_rds.port
  sensitive   = true
}

output "rds_username" {
  description = "RDS instance root username"
  value       = aws_db_instance.a03_db_1_rds.username
  sensitive   = true
}


# write data to file when resources are created
# file will be managed with terraform, deleted with resources are destroyed
resource "local_file" "vpc_vars_file" {
  content       = <<-eof
    rds_hostname: ${aws_db_instance.a03_db_1_rds.address}
    rds_port: ${aws_db_instance.a03_db_1_rds.port}
    rds_username: ${aws_db_instance.a03_db_1_rds.username}
  eof
  file_permission = "0640"
  filename         = "vars.yaml"
}