data "kubectl_file_documents" "node_pools" {
  for_each = { for pool in var.node_pools : pool.pool_name => pool }

  content = templatefile("${path.module}/templates/NodePool.yaml",
    {
      class_name : each.value.class_name,
      pool_name : each.value.pool_name,
      region : var.region,
      arch : toset(each.value.arch),
      instance_type : toset(each.value.instance_type),
      capacity : each.value.capacity,
      max_cpu : each.value.max_cpu,
      max_memory : each.value.max_memory,
      ttl : each.value.ttl,
      disruption_policy : each.value.disruption.policy,
      disruption_after : each.value.disruption.after,
      disruption_nodes_per_time : each.value.disruption.nodes_per_time,
    }
  )
}


resource "kubectl_manifest" "node_pools" {
  for_each = {
    for pool in var.node_pools :
    pool.pool_name => data.kubectl_file_documents.node_pools[pool.pool_name]
  }

  yaml_body = each.value.documents[0]

  depends_on = [kubectl_manifest.node_class]
}

