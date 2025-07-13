output "load_balancer_role_arn" {
  description = "ARN of the created IAM role for the Load Balancer Controller"
  value       = aws_iam_role.current.arn
}
