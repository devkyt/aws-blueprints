data "kubectl_file_documents" "karpenter_node_pool" {
  content = templatefile("${path.module}/templates/NodePool.yaml",
    {
      class_name : var.class_name,
      pool_name : var.pool_name,
      region : var.region,
      arch : toset(var.arch),
      instance_type : toset(var.instance_type),
      capacity : var.capacity,
      max_cpu : var.max_cpu,
      max_memory : var.max_memory,
      ttl : var.ttl,
      disruption_policy : var.disruption.policy,
      disruption_after : var.disruption.after,
      disruption_nodes_per_time : var.disruption.nodes_per_time,
      labels : merge(local.labels, { role = var.pool_name })
    }
  )
}


resource "kubectl_manifest" "karpenter_node_pool" {
  yaml_body = data.kubectl_file_documents.karpenter_node_pool.documents[0]
}
