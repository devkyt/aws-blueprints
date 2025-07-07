module "target_group_binding" {
  source = "git::git@github.com:devkyt/aws-blueprints.git//eks/aws-load-balancer/target-group-binding/module"

  service = {
    name      = "traefik"
    namespace = "default"
    port      = 80
  }

  target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/targetgroup/123456789012"

  labels = local.labels
}
