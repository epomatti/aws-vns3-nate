# General
workload   = "myapp"
aws_region = "us-east-2"
tags       = { "CreatedBy" = "Terraform" }

# VNS3
vns3_instance_type              = "t3.medium"
vns3_ami                        = "ami-02f11042622448b19"
vns3_allowed_webui_ip_addresses = ["0.0.0.0/0"]

# Server
create_private_server        = false
private_server_ami           = "ami-0504881b6db750d2f"
private_server_instance_type = "t4g.micro"

# VPC Endpoints
create_vpc_endpoints = false
