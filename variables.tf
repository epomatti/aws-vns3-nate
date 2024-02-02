### General ###
variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "workload" {
  type    = string
  default = ""
}

variable "tags" {
  type = map(string)
  default = {
    "CreatedBy" = "Terraform"
  }
}

### VNS3 ###
variable "vns3_instance_type" {
  type    = string
  default = "t3a.nano"
}

variable "vns3_ami" {
  type        = string
  default     = "ami-02f11042622448b19"
  description = "VNS3 NATe Free (NAT Gateway Appliance) 6.1.3-20230925"
}

variable "vns3_allowed_webui_ip_addresses" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "The IP addresses that are allowed to use the Web UI in VNS3 instance"
}

# variable "vns3_allowed_ssh_ip_addresses" {
#   type        = list(string)
#   default     = ["54.236.197.84/32"]
#   description = "The IP addresses that are allowed to SSH into the VNS3 instance"
# }

### Private Server ###
variable "create_private_server" {
  type    = bool
  default = true
}

variable "private_server_ami" {
  type        = string
  default     = "ami-0748d13ffbc370c2b"
  description = "Canonical, Ubuntu, 22.04 LTS, arm64 jammy image build on 2023-12-07"
}

variable "private_server_instance_type" {
  type    = string
  default = "t4g.nano"
}

### VPC Endpoints ###
variable "create_vpc_endpoints" {
  type        = bool
  default     = true
  description = "Enables or disables the creation of VPC endpoints for EC2 and SSM"
}
