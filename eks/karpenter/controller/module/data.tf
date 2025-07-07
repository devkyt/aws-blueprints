data "aws_eks_cluster" "current" {
  name = var.cluster_name
}

