variable "region" {
  description = "AWS region"
  default = "us-east-1"
}

variable "ami" {
  description = "Amazon Machine Image ID"
  default = "ami-04b4f1a9cf54c11d0"
}

variable "bastion_instance_type" {
  description = "Instance type for bastion"
  default = "t2.micro"
}

variable "mongodb_instance_type" {
  description = "Instance type for MongoDB"
  default = "t2.micro"
}

variable "webserver_instance_type" {
  description = "Instance type for web server (NGINX & Node.js)"
  default = "t2.micro"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  default = "10.0.2.0/24"
}
