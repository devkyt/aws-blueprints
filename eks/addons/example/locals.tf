locals {
  region = "eu-central-1"

  cluster = "mastermind"
  vpc_id  = data.aws_eks_cluster.current.vpc_config[0].vpc_id
}
