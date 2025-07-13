locals {
  env    = "dev"
  region = "eu-central-1"

  nodegroups = [
    {
      name          = "system"
      capacity_type = "ON_DEMAND"
      ami_type      = "AL2_ARM_64"
      instance_type = "m6g.large"

      scaling_config = {
        min_size     = 2
        max_size     = 4
        desired_size = 2
      }

      max_unavailable_on_update = 1

      labels = {}

      taint = {
        key    = "system"
        value  = "true"
        effect = "NO_SCHEDULE"
      }
    },
  ]

  karpenter_discovery_tags = {
    "karpenter.sh/discovery" = "dev"
  }

  labels = {
    team   = "queens-of-the-stone-age"
    office = "london"
  }

  tags = {
    Team   = "Queens of the Stone Age"
    Office = "London"
  }
}
