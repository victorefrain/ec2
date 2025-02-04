resource "aws_instance" "mongodb" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = [var.security_group_id]

  user_data = templatefile("${path.module}/install_mongodb.sh", {})

  tags = {
    Name = "mongodb"
  }
}


