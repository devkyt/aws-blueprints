resource "aws_eks_addon" "core_dns" {
  addon_name                  = "coredns"
  addon_version               = var.core_dns_addon.version
  cluster_name                = var.cluster
  resolve_conflicts_on_create = "OVERWRITE"

  configuration_values = jsonencode({
    replicaCount = var.core_dns_addon.replicas
    resources = {
      limits = {
        cpu    = "200m"
        memory = "200Mi"
      }
      requests = {
        cpu    = "200m"
        memory = "200Mi"
      }
    }
    tolerations  = var.core_dns_addon.tolerations
    nodeSelector = var.core_dns_addon.node_selector
    }
  )

  tags = merge(local.tags,
    {
      Name  = "${var.cluster}-core-dns"
      Type  = "CoreDNS"
      Addon = true
    }
  )
}
