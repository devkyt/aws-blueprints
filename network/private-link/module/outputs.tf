output "alb_target_arn" {
  description = "The ARN of the created ALB target group"
  value       = aws_lb_target_group.alb_target.arn
}


output "alb_security_group_arn" {
  description = "The ARN of the created ALB security group"
  value       = aws_security_group.alb_security_group.arn
}


output "private_link_dns_name" {
  description = "The DNS name of the created private link endpoint"
  value       = aws_vpc_endpoint.private_link_endpoint.dns_entry[0].dns_name
}
