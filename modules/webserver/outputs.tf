output "public_ip" {
  value = aws_instance.webserver.public_ip
}


output "webserver_id" {
  value = aws_instance.webserver.id
}