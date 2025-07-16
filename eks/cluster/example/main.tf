module "eks_cluster" {
  source = "git::git@github.com:devkyt/aws-blueprints.git//eks/cluster/module"

  env                 = local.env
  region              = local.region
  vpc_id              = data.aws_vpc.current.id
  private_subnets_ids = data.aws_subnets.private_subnets.ids

  cluster_name    = "mastermind"
  cluster_version = "1.31"

  karpenter_discovery_tags = local.karpenter_discovery_tags

  nodegroups = local.nodegroups

  labels = local.labels
  tags   = local.tags
}
