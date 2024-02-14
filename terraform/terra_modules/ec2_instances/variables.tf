variable "a03_be_subnet_id" {
  description = "Subnet ID for backend instances"
  type        = string
}

variable "a03_web_subnet_id" {
  description = "Subnet ID for web instances"
  type        = string
}

variable "a03_be_sg_id" {
  description = "be security id"
  type        = string
}

variable "a03_web_sg_id" {
  description = "web security id"
  type        = string
}

# variable for path of the public key
variable "pub_key_path" {
  description = "path of the public key"
  default = "/home/kaylyn/.ssh/terra.pub"
}