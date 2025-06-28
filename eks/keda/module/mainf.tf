resource "helm_release" "keda" {
  name = "keda"

  repository = "https://kedacore.github.io/charts"
  chart      = "keda"
  version    = var.keda.chart_version

  namespace        = var.keda.namespace
  create_namespace = true

  wait    = true
  timeout = 360

  values = [
    templatefile("${path.module}/templates/keda/values.yaml",
      {
        cluster_name : var.cluster_name,
        node_selector : var.keda.node_selector
        tolerations : var.keda.tolerations,
      }
    )
  ]
}
