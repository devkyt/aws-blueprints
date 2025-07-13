data "kubectl_file_documents" "node_classes" {
  for_each = { for class in var.node_classes : class.name => class }

  content = templatefile("${path.module}/templates/NodeClass.yaml",
    {
      class_name : each.value.name,
      iam_role : var.iam_role_name,
      ami : each.value.ami,
      cluster_name : local.cluster,
      security_group_id : local.cluster_security_group_id
    }
  )
}


resource "kubectl_manifest" "node_classes" {
  for_each = {
    for class in var.node_classes :
    class.name => data.kubectl_file_documents.node_classes[class.name]
  }

  yaml_body = each.value.documents[0]

  depends_on = [
    helm_release.karpenter,
    data.kubectl_file_documents.node_classes
  ]
}
