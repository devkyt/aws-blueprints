locals {
  database_identifier = "${var.env}-${var.service}-postgres"

  tags = merge(var.tags, {
    Env       = var.env
    PartOf    = var.service
    Terraform = true
  })
}
