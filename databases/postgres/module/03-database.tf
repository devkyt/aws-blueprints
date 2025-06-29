resource "random_string" "username" {
  length  = 10
  special = false
  upper   = false
}


resource "random_password" "password" {
  length  = 32
  special = false
  upper   = true
}


resource "aws_db_instance" "current" {
  engine         = "postgres"
  engine_version = var.postgres_version

  db_name    = var.database_name
  identifier = local.database_identifier

  username = random_string.username.result
  password = random_password.password.result

  instance_class = var.instance_type

  vpc_security_group_ids = [aws_security_group.current.id]
  db_subnet_group_name   = aws_db_subnet_group.current.name
  availability_zone      = var.availability_zone
  publicly_accessible    = var.network_rules.public

  storage_type      = var.storage.type
  storage_encrypted = var.storage.encrypted
  allocated_storage = var.storage.size

  maintenance_window         = var.maintenance.window
  auto_minor_version_upgrade = var.maintenance.auto_minor_version_upgrade
  backup_window              = var.backup.window
  backup_retention_period    = var.backup.retention
  deletion_protection        = true
  skip_final_snapshot        = true

  monitoring_interval             = 5
  monitoring_role_arn             = var.monitoring_role_arn
  enabled_cloudwatch_logs_exports = ["postgresql"]

  tags = merge(local.tags,
    {
      Name = "${local.database_identifier}-db"
      Type = "postgres"
      For  = var.service
    }
  )
}
