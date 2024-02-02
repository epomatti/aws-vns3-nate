variable "workload" {
  type = string
}

variable "subnet" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_profile_id" {
  type = string
}

variable "allowed_webui_ip_addresses" {
  type = list(string)
}

variable "allowed_ssh_ip_addresses" {
  type = list(string)
}
