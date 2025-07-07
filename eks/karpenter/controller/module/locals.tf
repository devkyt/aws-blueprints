locals {
  cluster_name              = data.aws_eks_cluster.current.name
  cluster_endpoint          = data.aws_eks_cluster.current.endpoint
  cluster_security_group_id = data.aws_eks_cluster.current.vpc_config[0].cluster_security_group_id

  tags = merge(var.tags, {
    Env       = var.env
    Cluster   = local.cluster_name
    Terraform = true
  })
}
