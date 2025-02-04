variable "instance_type" {
  description = "Instance type for web server"
}

variable "ami" {
  description = "Amazon Machine Image ID"
}

variable "subnet_id" {
  description = "Subnet ID for web server"
}

variable "security_group_id" {
  description = "Security group ID for web server"
}
