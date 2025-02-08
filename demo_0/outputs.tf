output "demo0_sg_name" {
  value = aws_security_group.demo0.name
}

output "demo0_sg_ingress" {
  value = aws_security_group.demo0.ingress
}

output "demo0_alb_dns" {
  value = aws_lb.demo0.dns_name
}
output "demo0_alb_subnets" {
  value = aws_lb.demo0.subnets
}