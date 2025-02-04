variable "instance_type" {
  description = "Instance type for bastion"
}

variable "ami" {
  description = "Amazon Machine Image ID"
}

variable "subnet_id" {
  description = "Subnet ID for bastion"
}

variable "security_group_id" {
  description = "Security group ID for bastion"
}
