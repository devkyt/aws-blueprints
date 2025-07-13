locals {
  tags = merge(var.tags,
    {
      Env       = var.env
      Cluster   = var.cluster
      Terraform = true
    }
  )
}
