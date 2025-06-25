resource "helm_release" "secret_store_csi_provider_aws" {
  name = "secret-store-csi-provider-aws"

  repository = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
  chart      = "secrets-store-csi-driver-provider-aws"
  version    = var.secrets_store_csi_provider_aws.chart_version

  namespace        = coalesce(var.secrets_store_csi_provider_aws.namespace, var.namespace)
  create_namespace = true

  wait    = true
  timeout = 360

  values = [
    templatefile("${path.module}/charts/csi-provider.values.yaml",
      {
        resources = var.secrets_store_csi_provider_aws_resources
      }
    )
  ]

  depends_on = [helm_release.secret_store_csi_driver]
}
