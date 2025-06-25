locals {
  common_tags          = merge(var.tags, { Environment = var.env })
  private_subnets_tags = merge(local.common_tags, var.private_subnets.tags)
  public_subnets_tags  = merge(local.common_tags, var.public_subnets.tags)
}
