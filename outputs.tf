output "bastion_public_ip" {
  value = module.bastion.public_ip
}

output "mongodb_public_ip" {
  value = module.mongodb.public_ip
}

output "webserver_public_ip" {
  value = module.webserver.public_ip
}

output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_id" {
  value = module.network.public_subnet_id
}

output "private_subnet_id" {
  value = module.network.private_subnet_id
}
