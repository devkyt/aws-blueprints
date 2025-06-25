resource "aws_eks_addon" "core_dns" {
  cluster_name                = var.cluster_name
  addon_name                  = var.core_dns_addon.name
  addon_version               = var.core_dns_addon.version
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
    tolerations  = var.system_workload_common_config.tolerations
    nodeSelector = var.system_workload_common_config.node_selector
    }
  )

  tags = merge(local.tags,
    {
      Name  = "core-dns"
      Type  = "DNS"
      Addon = true
    }
  )
}
