variable "instance_type" {
  description = "Instance type for MongoDB"
}

variable "ami" {
  description = "Amazon Machine Image ID"
}

variable "subnet_id" {
  description = "Subnet ID for MongoDB"
}

variable "security_group_id" {
  description = "Security group ID for MongoDB"
}
