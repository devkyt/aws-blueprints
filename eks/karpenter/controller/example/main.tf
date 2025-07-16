module "karpenter" {
  source = "git::git@github.com:devkyt/aws-blueprints.git//eks/karpenter/controller/module"

  env    = local.env
  region = local.region

  cluster   = local.cluster
  namespace = "karpenter"

  module_version               = "20.36.0"
  chart_version                = "1.4.0"
  iam_role_name                = "karpenter"
  iam_role_additional_policies = {}

  node_selector = {
    system = "true"
  }

  tolerations = [
    {
      key      = "system"
      operator = "Equal"
      value    = "true"
      effect   = "NoSchedule"
    }
  ]

  node_classes = [
    {
      name = "default"
      ami  = "ami-00a61821236f192f0"
    }
  ]

  node_pools = [
    {
      class_name    = "default"
      pool_name     = "default"
      arch          = ["amd64"]
      instance_type = ["t3g.medium"]
      capacity      = ["spot"]
      max_cpu       = 640
      max_memory    = "2000Gi"
      ttl           = "720h"
      disruption = {
        policy         = "WhenEmptyOrUnderutilized"
        nodes_per_time = "1"
        after          = "30s"
      }
    }
  ]

  tags = {
    Office = "London"
    Team   = "Queens of the Stone Age"
  }
}
