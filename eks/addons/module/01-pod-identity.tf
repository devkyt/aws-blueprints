resource "aws_eks_addon" "pod_identity" {
  cluster_name                = var.cluster_name
  addon_name                  = "eks-pod-identity-agent"
  addon_version               = "v1.2.0-eksbuild.1"
  resolve_conflicts_on_create = "OVERWRITE"

  configuration_values = jsonencode({ tolerations = [{ operator = "Exists" }] })

  tags = merge(local.tags,
    {
      Name  = "pod-identity"
      Type  = "IAM"
      Addon = true
    }
  )
}
