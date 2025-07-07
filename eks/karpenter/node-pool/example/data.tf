data "aws_eks_cluster" "eks" {
  name = local.cluster_name
}
