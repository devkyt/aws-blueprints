resource "aws_eks_addon" "pod_identity" {
  addon_name                  = "eks-pod-identity-agent"
  addon_version               = var.pod_identity_addon.version
  cluster_name                = var.cluster_name
  resolve_conflicts_on_create = "OVERWRITE"

  configuration_values = jsonencode({ tolerations = [{ operator = "Exists" }] })

  tags = merge(local.tags,
    {
      Name  = "${var.cluster_name}-pod-identity"
      Type  = "Pod Identity Addon"
      Addon = true
    }
  )
}
