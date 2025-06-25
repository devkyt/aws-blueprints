locals {
  database_identifier = "${var.env}-${var.service}-postgres"

  tags = merge(var.tags,
    {
      Environment = var.env
      PartOf      = var.service
      Terraform   = true
    }
  )
}
