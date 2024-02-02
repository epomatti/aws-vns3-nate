locals {
  name = "${var.workload}-server"
}

resource "aws_instance" "server" {
  ami                  = var.ami
  instance_type        = var.instance_type
  iam_instance_profile = var.instance_profile_id

  associate_public_ip_address = false
  subnet_id                   = var.subnet
  vpc_security_group_ids      = [aws_security_group.default.id]
  ebs_optimized               = true

  # Enables metadata V2
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    encrypted   = true
    volume_type = "gp3"

    tags = {
      "Name" = "ebs-${local.name}"
    }
  }

  tags = {
    Name = "${local.name}-server"
  }
}


resource "aws_security_group" "default" {
  name   = "${var.workload}-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "sg-${var.workload}"
  }
}

resource "aws_security_group_rule" "egress_http" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "egress_https" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default.id
}
