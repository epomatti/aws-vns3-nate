output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_private_id" {
  value = aws_subnet.private.id
}

output "subnet_public_id" {
  value = aws_subnet.public.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}
