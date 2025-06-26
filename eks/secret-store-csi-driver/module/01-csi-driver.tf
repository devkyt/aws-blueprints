resource "helm_release" "secret_store_csi_driver" {
  name = "secret-store-csi-driver"

  repository = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  chart      = "secrets-store-csi-driver"
  version    = var.secrets_store_csi_driver.chart_version

  namespace        = coalesce(var.secrets_store_csi_driver.namespace, var.namespace)
  create_namespace = true

  wait    = true
  timeout = 360

  values = [
    templatefile("${path.module}/charts/csi-driver.values.yaml",
      {
        resources   = var.secrets_store_csi_driver_resources
        sync_secret = var.sync_secrets_to_cluster
      }
    )
  ]
}
