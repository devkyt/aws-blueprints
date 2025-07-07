module "secrets_provider_class" {
  source = "git::git@github.com:devkyt/aws-blueprints.git//eks/secret-store-csi-driver/provider-class/module"

  name      = "secrets"
  namespace = "default"

  use_pod_identity = true

  secrets = [
    {
      name = "secrets"
      arn  = "arn:aws:secretsmanager:eu-central-1:123456789012:secret:secrets"
      key  = "secrets"
    }
  ]

  labels = local.labels
}
