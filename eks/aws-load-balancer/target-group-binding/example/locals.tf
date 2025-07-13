locals {
  region = "eu-central-1"

  cluster_name           = "mastermind"
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  cluster_endpoint       = data.aws_eks_cluster.eks.endpoint

  labels = {
    office = "London"
    team   = "Queens of the Stone Age"
  }
}
