resource "helm_release" "load_balancer" {
  name = var.release_name

  repository   = "https://aws.github.io/eks-charts"
  chart        = "aws-load-balancer-controller"
  version      = var.chart_version
  namespace    = var.namespace
  force_update = true

  values = [templatefile("${path.module}/charts/load-balancer.values.yaml",
    {
      cluster_name : var.cluster,
      service_account_name : var.service_account,
      region : var.region,
      vpc_id : var.vpc_id,
      tolerations : var.tolerations,
      node_selector : var.node_selector
    }
    )
  ]
}
