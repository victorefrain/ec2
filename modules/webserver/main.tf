


resource "aws_instance" "webserver" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = [var.security_group_id]

  associate_public_ip_address = var.associate_public_ip_address

  user_data = file("${path.module}/install_sh.sh")

  tags = {
    Name = "webserver"
  }
}




resource "aws_lb_target_group_attachment" "webserver_public" {
  target_group_arn = module.load_balancer.app_tg
  target_id        = module.webserver_public.webserver_id
  port             = 80
}

resource "aws_lb_target_group_attachment" "webserver_private" {
  target_group_arn = module.load_balancer.app_tg
  target_id        = module.webserver_private.webserver_id
  port             = 80
}