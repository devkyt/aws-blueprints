locals {
  name = "${var.env}-${var.name}-alb"

  tags = merge(var.tags,
    {
      Env       = var.env
      PartOf    = local.name
      Terraform = true
    }
  )
}
