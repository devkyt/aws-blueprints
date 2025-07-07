module "karpenter_node_pool" {
  source = "git::git@github.com:devkyt/aws-blueprints.git//eks/karpenter/node-pool/module"

  region = local.region

  class_name = "default"
  pool_name  = "master"

  arch = ["arm64"]

  instance_type = [
    "m8g.xlarge",
    "m8gd.xlarge",
    "m7gd.xlarge"
  ]

  capacity = ["on-demand"]

  max_cpu    = 50
  max_memory = "160Gi"

  ttl = "1440h"

  disruption = {
    policy         = "WhenEmptyOrUnderutilized"
    nodes_per_time = "1"
    after          = "10m"
  }
}
