
output "bastion_sg_id" {
  value = aws_security_group.bastion.id
}

output "mongodb_sg_id" {
  value = aws_security_group.mongodb.id
}

output "webserver_sg_id" {
  value = aws_security_group.webserver.id
}
