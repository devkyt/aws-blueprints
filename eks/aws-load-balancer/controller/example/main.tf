module "load_balancer" {
  source = "git::git@github.com:devkyt/aws-blueprints.git//eks/aws-load-balancer/controller/module"

  env    = local.env
  region = local.region
  vpc_id = local.vpc_id

  cluster   = local.cluster
  namespace = "kube-system"

  chart_version = "1.13.3"
  release_name  = "aws-load-balancer"

  service_account = "aws-load-balancer-controller"

  node_selector = {
    role = "system"
  }

  tolerations = [
    {
      key      = "system"
      operator = "Equal"
      value    = "true"
      effect   = "NoSchedule"
    }
  ]

  tags = {
    Office = "London"
    Team   = "Queens of the Stone Age"
  }
}
