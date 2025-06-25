output "database_arn" {
  description = "ARN of the createddatabase"
  value       = aws_db_instance.current.arn
}


output "secret_arn" {
  description = "ARN of the created secret"
  value       = aws_secretsmanager_secret.main.arn
}


output "secret_version_id" {
  description = "ID of the secret version"
  value       = aws_secretsmanager_secret_version.main.id
}
