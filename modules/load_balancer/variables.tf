variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs to attach to the load balancer"
  type        = list(string)
}

variable "security_group_id" {
  description = "The ID of the security group to associate with the load balancer"
  type        = string
}
