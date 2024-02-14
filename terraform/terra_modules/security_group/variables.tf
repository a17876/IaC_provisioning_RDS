# variable for home cdir block 
variable "home_cidr_block" {
  description = "home cidr block"
  default = "207.216.90.233/32"
}

# variable for bcit cdir block 
variable "bcit_cidr_block" {
  description = "bcit cidr block"
  default = "142.232.0.0/16"
}

# variable for private subnet cidr block
variable "sub_be_cidr_block" {
  description = "private subnet cidr block"
  default = "192.168.1.0/24"
}

# variable for public subnet cidr block
variable "sub_web_cidr_block" {
  description = "public subnet cidr block"
  default = "192.168.2.0/24"
}

# variable for vpc cidr block
variable "base_cidr_block" {
  description = "default cidr block"
  default = "192.168.0.0/16"
}

variable "a03_vpc_id" {
  description = "VPC ID"
  type        = string
}