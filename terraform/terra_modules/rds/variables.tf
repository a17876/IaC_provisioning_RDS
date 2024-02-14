variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
  default = "password"
}

variable "db_username" {
  description = "RDS root user name"
  type        = string
  sensitive   = true
  default = "username"
}

variable "a03_db_1_sg_id" {
  description = "security group ID for db 1 "
  type        = string
}

variable "a03_db_1_subnet_id" {
  description = "subnet ID for db 1 "
  type        = string
}

variable "a03_db_2_subnet_id" {
  description = "subnet ID for db 2 "
  type        = string
}