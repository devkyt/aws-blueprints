resource "aws_eks_node_group" "nodes" {
  for_each = { for group in var.nodegroups : group.name => group }

  cluster_name = var.cluster_name
  version      = var.cluster_version

  node_group_name = each.key
  node_role_arn   = aws_iam_role.nodes.arn

  subnet_ids = var.private_subnets_ids

  capacity_type  = each.value.capacity_type
  ami_type       = each.value.ami_type
  instance_types = [each.value.instance_type]

  scaling_config {
    desired_size = each.value.scaling_config.desired_size
    max_size     = each.value.scaling_config.max_size
    min_size     = each.value.scaling_config.min_size
  }

  update_config {
    max_unavailable = each.value.max_unavailable_on_update
  }

  dynamic "taint" {
    for_each = each.value.taint[*]

    content {
      key    = each.value.taint.key
      value  = each.value.taint.value
      effect = each.value.taint.effect
    }
  }

  labels = merge(var.labels,
    each.value.labels,
    {
      role     = each.key,
      instance = each.value.instance_type
    }
  )

  depends_on = [
    aws_eks_cluster.cluster,
    aws_iam_role_policy_attachment.worker_node_policy_attachment,
    aws_iam_role_policy_attachment.eks_cni_policy_attachment,
    aws_iam_role_policy_attachment.ecr_readonly_policy_attachment
  ]

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  tags = merge(local.tags,
    {
      Name = "${var.cluster_name}-nodegroup"
      Type = "Node Group"
    }
  )
}
