module "karpenter" {
  source  = "terraform-aws-modules/eks/aws//modules/karpenter"
  version = var.karpenter.module_version

  cluster_name          = var.cluster_name
  namespace             = var.karpenter.namespace
  enable_v1_permissions = true

  node_iam_role_use_name_prefix   = false
  node_iam_role_name              = var.iam_role_name
  enable_pod_identity             = true
  create_pod_identity_association = true

  node_iam_role_additional_policies = merge(var.iam_role_additional_policies,
    {
      AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      AmazonEKSWorkerNodePolicy    = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
      AmazonEKS_CNI_Policy         = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
      AmazonEBSCSIDriverPolicy     = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
    }
  )

  tags = merge(local.tags,
    {
      Name    = "karpenter"
      Cluster = local.cluster_name
      Type    = "autoscaler"
    }
  )
}


resource "helm_release" "karpenter" {
  name = "karpenter"

  repository = "oci://public.ecr.aws/karpenter"
  chart      = "karpenter"
  version    = var.karpenter.chart_version

  namespace        = var.karpenter.namespace
  create_namespace = true

  wait    = true
  timeout = 360

  values = [
    templatefile("${path.module}/chart/values.yaml",
      {
        cluster_name : local.cluster_name,
        cluster_endpoint : local.cluster_endpoint,
        interruption_queue : module.karpenter.queue_name,
        node_selector : var.karpenter.node_selector,
        tolerations : var.karpenter.tolerations,
      }
    )
  ]

  depends_on = [module.karpenter]
}
