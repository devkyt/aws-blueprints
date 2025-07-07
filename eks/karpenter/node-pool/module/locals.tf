locals {
  labels = merge(var.labels,
    {
      type      = "karpenter-node-pool"
      terraform = "true"
    }
  )
}
