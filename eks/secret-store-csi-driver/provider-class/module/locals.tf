locals {
  labels = merge(var.labels,
    {
      type      = "secrets-store"
      terraform = "true"
    }
  )
}
