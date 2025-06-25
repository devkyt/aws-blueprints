output "load_balancer_arn" {
  description = "The ARN of the created load balancer"
  value       = aws_lb.current.arn
}


output "security_group_arn" {
  description = "The ARN of the load balancer security group"
  value       = aws_security_group.current.arn
}


output "target_group_arn" {
  description = "The ARN of the created target group"
  value       = coalesce(aws_lb_target_group.current[0].arn, var.target_group.arn)
}
