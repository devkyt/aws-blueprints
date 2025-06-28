resource "aws_db_subnet_group" "current" {
  name       = "${local.database_identifier}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(local.tags,
    {
      Name = "${local.database_identifier}-subnet-group"
      Type = "Subnet Group"
      For  = local.database_identifier
  })
}
