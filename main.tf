terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.34.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = var.tags
  }
}

module "vpc" {
  source   = "./modules/vpc"
  region   = var.aws_region
  workload = var.workload
}

module "iam" {
  source   = "./modules/iam"
  workload = var.workload
}

module "vns3" {
  source              = "./modules/vns3"
  workload            = var.workload
  vpc_id              = module.vpc.vpc_id
  subnet              = module.vpc.subnet_public_id
  instance_type       = var.vns3_instance_type
  ami                 = var.vns3_ami
  instance_profile_id = module.iam.ec2_instance_profile_id

  allowed_webui_ip_addresses = var.vns3_allowed_webui_ip_addresses
  allowed_ssh_ip_addresses   = var.vns3_allowed_ssh_ip_addresses
}

# module "private_server" {
#   count                    = var.create_private_server == true ? 1 : 0
#   source                   = "./modules/ec2/server"
#   workload                 = var.workload
#   vpc_id                   = module.vpc.vpc_id
#   subnet                   = module.vpc.subnet_private1_id
#   region                   = var.region
#   route_table_id           = module.vpc.private_route_table_id
#   nat_network_interface_id = module.nat-instance[0].network_interface_id
# }
