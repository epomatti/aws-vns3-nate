locals {
  name = "${var.workload}-vns3"
}

resource "aws_eip" "default" {
  domain = "vpc"

  tags = {
    Name = "vns3-elastic-ip"
  }
}

resource "aws_key_pair" "default" {
  key_name   = "${local.name}-key"
  public_key = file("${path.module}/../../keys/vns3.pub")
}

resource "aws_instance" "default" {
  ami                  = var.ami
  instance_type        = var.instance_type
  iam_instance_profile = var.instance_profile_id
  key_name             = aws_key_pair.default.key_name

  associate_public_ip_address = true
  subnet_id                   = var.subnet
  vpc_security_group_ids      = [aws_security_group.default.id]
  ebs_optimized               = true

  user_data = file("${path.module}/userdata.sh")

  # Requirement for NAT
  source_dest_check = false

  root_block_device {
    encrypted   = true
    volume_type = "gp3"

    tags = {
      "Name" = "ebs-${var.workload}"
    }
  }

  tags = {
    Name = local.name
  }
}

### IAM Role ###
resource "aws_security_group" "default" {
  name   = "${local.name}-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "sg-${local.name}"
  }
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

resource "aws_security_group_rule" "ingres_http_from_vpc" {
  description       = "Allows incoming HTTP traffic from the VPC"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = [data.aws_vpc.selected.cidr_block]
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "ingress_https_from_vpc" {
  description       = "Allows incoming HTTPS traffic from the VPC"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  cidr_blocks       = [data.aws_vpc.selected.cidr_block]
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "vns3_webui" {
  type              = "ingress"
  from_port         = 8000
  to_port           = 8000
  protocol          = "tcp"
  cidr_blocks       = var.allowed_webui_ip_addresses
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "ingress_ssh" {
  description       = "Allows SSH administration"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.allowed_ssh_ip_addresses
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "egress_all" {
  description       = "For simplicity, allows all outbound traffic. Review this for production."
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default.id
}
