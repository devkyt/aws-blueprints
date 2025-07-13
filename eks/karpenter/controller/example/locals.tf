locals {
  region = "eu-central-1"

  cluster          = "mastermind"
  cluster_endpoint = data.aws_eks_cluster.current.endpoint
  cluster_ca       = base64decode(data.aws_eks_cluster.current.certificate_authority[0].data)
}
