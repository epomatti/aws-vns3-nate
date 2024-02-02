output "primary_network_interface_id" {
  value = aws_instance.default.primary_network_interface_id
}

output "public_ip" {
  value = aws_instance.default.public_ip
}

output "instance_id" {
  value = aws_instance.default.id
} 
