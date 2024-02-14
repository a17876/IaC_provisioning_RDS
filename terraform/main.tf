terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
}

module "my_vpc" {
  source = "./terra_modules/a03_vpc"
}

module "security_group" {
  source = "./terra_modules/security_group"
  a03_vpc_id = module.my_vpc.a03_vpc_id
}

module "ec2_instances" {
  source = "./terra_modules/ec2_instances"
  a03_be_subnet_id = module.my_vpc.a03_be_subnet_id
  a03_web_subnet_id = module.my_vpc.a03_web_subnet_id
  a03_be_sg_id = module.security_group.a03_be_sg_id
  a03_web_sg_id = module.security_group.a03_web_sg_id
}

module "rds" {
  source = "./terra_modules/rds"
  a03_db_1_sg_id = module.security_group.a03_db_1_sg_id
  a03_db_1_subnet_id = module.my_vpc.a03_db_1_subnet_id
  a03_db_2_subnet_id = module.my_vpc.a03_db_2_subnet_id
}

