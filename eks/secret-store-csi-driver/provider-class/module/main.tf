data "kubectl_file_documents" "secrets_provider_class" {
  content = templatefile("${path.module}/templates/ProviderClass.yaml",
    {
      name : var.name,
      namespace : var.namespace,
      use_pod_identity : var.use_pod_identity,
      secrets : var.secrets,
      labels : local.labels
    }
  )
}


resource "kubectl_manifest" "secrets_provider_class" {
  yaml_body = data.kubectl_file_documents.secrets_provider_class.documents[0]
}
