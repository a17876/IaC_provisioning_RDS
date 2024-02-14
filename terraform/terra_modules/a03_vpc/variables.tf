# variable for vpc cidr block
variable "base_cidr_block" {
  description = "default cidr block"
  default = "192.168.0.0/16"
}

# variable for be subnet cidr block
variable "sub_be_cidr_block" {
  description = "be subnet cidr block"
  default = "192.168.1.0/24"
}

# variable for web subnet cidr block
variable "sub_web_cidr_block" {
  description = "web subnet cidr block"
  default = "192.168.2.0/24"
}


# variable for db_1 subnet cidr block
variable "sub_db_1_cidr_block" {
  description = "db_1 subnet cidr block"
  default = "192.168.3.0/24"
}

# variable for db_2 subnet cidr block
variable "sub_db_2_cidr_block" {
  description = "db_2 subnet cidr block"
  default = "192.168.4.0/24"
}
