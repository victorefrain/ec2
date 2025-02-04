resource "aws_instance" "webserver" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = [var.security_group_id]

  user_data = templatefile("${path.module}/install_webserver.sh", {})

  tags = {
    Name = "webserver"
  }
}

output "public_ip" {
  value = aws_instance.webserver.public_ip
}
