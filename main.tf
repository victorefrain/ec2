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

module "webserver_public" {
  source = "./modules/webserver"
  instance_type = var.webserver_instance_type
  ami = var.ami
  subnet_id = module.network.public_subnet_id
  security_group_id = module.security.webserver_sg_id
  associate_public_ip_address = true # Para asignar una IP pública
}

module "webserver_private" {
  source = "./modules/webserver"
  instance_type = var.webserver_instance_type
  ami = var.ami
  subnet_id = module.network.private_subnet_id
  security_group_id = module.security.webserver_sg_id
  associate_public_ip_address = false # No asignar una IP pública
}

module "load_balancer" {
  source = "./modules/load_balancer"
  vpc_id = module.network.vpc_id
  subnets = [module.network.public_subnet_id, module.network.private_subnet_id]
  security_group_id = module.security.lb_sg_id
}

# Asociar instancias web al grupo de destino del balanceador de carga
resource "aws_lb_target_group_attachment" "webserver_public" {
  target_group_arn = module.load_balancer.app_tg
  target_id        = module.webserver.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "webserver_private" {
  target_group_arn = module.load_balancer.app_tg
  target_id        = module.webserver.id
  port             = 80
}

# Asociar instancia de mongodb al grupo de destino del balanceador de carga
resource "aws_lb_target_group_attachment" "mongodb" {
  target_group_arn = module.load_balancer.app_tg
  target_id        = module.mongodb.mongodb_instance.id
  port             = 27017 # Puerto de MongoDB
}
