locals {
  labels = merge(var.labels,
    {
      type      = "target-group-binding"
      terraform = "true"
    }
  )
}
