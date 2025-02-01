output "app_lb_dns_name" {
  value = aws_lb.app_lb.dns_name
}

output "app_tg" {
  value = aws_lb_target_group.app_tg.arn
}