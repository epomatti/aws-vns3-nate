# General
workload   = "myapp"
aws_region = "us-east-2"
tags       = { "CreatedBy" = "Terraform" }

# VNS3
vns3_instance_type = "t3.small"
vns3_ami           = "ami-02f11042622448b19"

# Server
create_private_server        = false
private_server_ami           = "ami-0748d13ffbc370c2b"
private_server_instance_type = "t4g.nano"

# VPC Endpoints
create_vpc_endpoints = false
