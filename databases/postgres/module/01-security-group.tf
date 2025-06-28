resource "aws_security_group" "current" {
  name   = "${local.database_identifier}-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = var.network_rules.port
    to_port         = var.network_rules.port
    protocol        = var.network_rules.protocol
    security_groups = var.network_rules.allowed_security_groups
  }

  tags = merge(local.tags, {
    Name = "${local.database_identifier}-sg"
    Type = "Security Group"
    For  = local.database_identifier
  })
}
