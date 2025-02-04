provider "aws" {
  region = var.region
}

module "network" {
  source = "./modules/network"
  vpc_cidr = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "security" {
  source = "./modules/security"
  vpc_id = module.network.vpc_id
  public_subnet_id = module.network.public_subnet_id
  private_subnet_id = module.network.private_subnet_id
  # No necesita vpc_cidr, public_subnet_cidr y private_subnet_cidr
}

module "bastion" {
  source = "./modules/bastion"
  instance_type = var.bastion_instance_type
  ami = var.ami
  subnet_id = module.network.public_subnet_id
  security_group_id = module.security.bastion_sg_id
}

module "mongodb" {
  source = "./modules/mongodb"
  instance_type = var.mongodb_instance_type
  ami = var.ami
  subnet_id = module.network.private_subnet_id
  security_group_id = module.security.mongodb_sg_id
}

module "webserver" {
  source = "./modules/webserver"
  instance_type = var.webserver_instance_type
  ami = var.ami
  subnet_id = module.network.private_subnet_id
  security_group_id = module.security.webserver_sg_id
}

module "load_balancer" {
  source = "./modules/load_balancer"
  security_group_id = aws_security_group.lb_sg.id
  subnet_ids        = [aws_subnet.example1.id, aws_subnet.example2.id]
  vpc_id            = aws_vpc.example.id
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "example1" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "example2" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.2.0/24"
}

resource "aws_security_group" "lb_sg" {
  vpc_id = aws_vpc.example.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.example1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.example2.id
  route_table_id = aws_route_table.public.id
}



resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id
}
