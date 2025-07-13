locals {
  tags = merge(var.tags,
    {
      Env       = var.env
      Cluster   = var.cluster_name
      Terraform = true
    }
  )
}
