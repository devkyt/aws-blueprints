module "secret_store_csi_driver" {
  source = "git::git@github.com:devkyt/aws-blueprints.git//eks/secret-store-csi-driver/controller/module"

  namespace               = "default"
  sync_secrets_to_cluster = true

  secrets_store_csi_driver = { chart_version = "1.5.1" }

  secrets_store_csi_driver_resources = {
    limits = {
      cpu    = "100m"
      memory = "100Mi"
    }
    requests = {
      cpu    = "100m"
      memory = "100Mi"
    }
  }

  secrets_store_csi_provider_aws = { chart_version = "1.0.1" }

  secrets_store_csi_provider_aws_resources = {
    limits = {
      cpu    = "100m"
      memory = "100Mi"
    }
    requests = {
      cpu    = "100m"
      memory = "100Mi"
    }
  }
}
