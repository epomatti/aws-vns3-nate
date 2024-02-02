locals {
  region_endpoint = "com.amazonaws.${var.aws_region}"
  endpoints = [
    "${local.region_endpoint}.ssm",
    "${local.region_endpoint}.ec2messages",
    "${local.region_endpoint}.ec2",
    "${local.region_endpoint}.ssmmessages",
  ]
}

resource "aws_vpc_endpoint" "endpoints" {
  for_each            = toset(local.endpoints)
  vpc_id              = var.vpc_id
  service_name        = each.value
  vpc_endpoint_type   = "Interface"
  auto_accept         = true
  subnet_ids          = [var.subnet]
  ip_address_type     = "ipv4"
  private_dns_enabled = true

  security_group_ids = [
    var.security_group_id,
  ]
}

