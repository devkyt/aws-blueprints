data "aws_eks_cluster" "current" {
  name = local.cluster
}
