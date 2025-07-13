resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.cluster.arn

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    subnet_ids              = var.private_subnets_ids
    security_group_ids      = var.security_groups_ids
  }

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  enabled_cluster_log_types = [
    "api",
    "authenticator",
    "audit",
    "scheduler",
    "controllerManager"
  ]

  depends_on = [aws_iam_role_policy_attachment.cluster_policy_attachment]

  tags = merge(local.tags,
    {
      Name = "${var.cluster_name}-cluster"
      Type = "EKS Cluster"
    }
  )
}
