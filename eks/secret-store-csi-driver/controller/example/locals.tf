locals {
  region = "eu-central-1"

  cluster_name           = "mastermind"
  cluster_endpoint       = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
}
