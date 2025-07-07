data "kubectl_file_documents" "target_group_binding" {
  content = templatefile("${path.module}/templates/TargetGroupBinding.yaml",
    {
      name : coalesce(var.name, "${var.service.name}-binding"),
      service : var.service,
      targetGroupARN : var.target_group_arn,
      labels : local.labels
    }
  )
}

resource "kubectl_manifest" "target_group_binding" {
  yaml_body = data.kubectl_file_documents.target_group_binding.documents[0]
}
