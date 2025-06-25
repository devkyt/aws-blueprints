data "kubectl_file_documents" "node_class" {
  content = templatefile("${path.module}/templates/NodeClass.yaml",
    {
      class_name : var.node_class.name,
      iam_role : var.iam_role_name,
      ami : var.node_class.ami,
      cluster_name : local.cluster_name,
      security_group_id : local.cluster_security_group_id
    }
  )
}


resource "kubectl_manifest" "node_class" {
  yaml_body = data.kubectl_file_documents.node_class.documents[0]

  depends_on = [helm_release.karpenter]
}
