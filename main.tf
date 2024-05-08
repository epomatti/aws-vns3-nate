terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.48.0"
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

# module "vpc_endpoints" {
#   source = "./modules/endpoints"
#   vpc_id = module.vpc.vpc_id
#   aws_region = var.aws_region
#   security_group_id = 
# }

module "iam" {
  source   = "./modules/iam"
  workload = var.workload
}

module "vns3" {
  source                     = "./modules/vns3"
  workload                   = var.workload
  vpc_id                     = module.vpc.vpc_id
  subnet                     = module.vpc.public_subnet_id
  instance_type              = var.vns3_instance_type
  ami                        = var.vns3_ami
  instance_profile_id        = module.iam.ec2_instance_profile_id
  allowed_webui_ip_addresses = var.vns3_allowed_webui_ip_addresses
}

resource "aws_route" "nat" {
  route_table_id         = module.vpc.private_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = module.vns3.primary_network_interface_id
}

module "server" {
  count               = var.create_private_server == true ? 1 : 0
  source              = "./modules/server"
  workload            = var.workload
  vpc_id              = module.vpc.vpc_id
  subnet              = module.vpc.private_subnet_id
  instance_type       = var.private_server_instance_type
  ami                 = var.private_server_ami
  instance_profile_id = module.iam.ec2_instance_profile_id
}
