resource "aws_secretsmanager_secret" "main" {
  name        = "${local.database_identifier}-secret"
  description = "Credentials for the ${local.database_identifier} database"

  tags = merge(local.tags,
    {
      Name = "${local.database_identifier}-secret"
      For  = local.database_identifier
    }
  )

  depends_on = [aws_db_instance.current]
}


resource "aws_secretsmanager_secret_version" "main" {
  secret_id = aws_secretsmanager_secret.main.id
  secret_string = jsonencode({
    host     = aws_db_instance.current.address
    port     = aws_db_instance.current.port
    db_name  = aws_db_instance.current.db_name
    username = random_string.username.result
    password = random_password.password.result
  })

  depends_on = [aws_db_instance.current, aws_secretsmanager_secret.main]
}
