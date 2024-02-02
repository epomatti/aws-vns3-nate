output "vns3_web_ui" {
  value = "https://${module.vns3.public_ip}:8000"
}

output "vns3_instance_id" {
  value = module.vns3.instance_id
}
