output "load_balancer_role_arn" {
  description = "ARN of the created IAM role for the Load Balancer Controller"
  value       = module.load_balancer.load_balancer_role_arn
}
