module "addons" {
  source = "git::git@github.com:devkyt/aws-blueprints.git//eks/addons/module"

  env    = "dev"
  region = local.region

  vpc_id    = local.vpc_id
  cluster   = local.cluster
  namespace = "kube-system"

  pod_identity_addon = {
    version = "v1.3.7-eksbuild.2"
  }

  core_dns_addon = {
    version  = "v1.11.1"
    replicas = 3
  }

  ebs_csi_driver_addon = {
    version              = "v1.45.0-eksbuild.2"
    service_account_name = "ebs-csi-controller-sa"

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
  }

  tags = {
    Office = "London"
    Team   = "Queens of the Stone Age"
  }
}
