locals {
  name = "${var.env}-${var.name}-alb"

  tags = merge(var.tags,
    {
      Environment = var.env
      PartOf      = local.name
      Terraform   = true
    }
  )
}
