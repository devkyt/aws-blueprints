data "aws_iam_policy_document" "load_balancer" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

resource "aws_iam_role" "load_balancer" {
  name               = "${var.cluster_name}-load-balancer"
  assume_role_policy = data.aws_iam_policy_document.load_balancer.json

  tags = merge(local.tags,
    {
      Name = "load-balancer"
      Type = "Role"
    }
  )
}

resource "aws_iam_policy" "load_balancer_policy" {
  name   = "AWSLoadBalancerController"
  policy = file("${path.module}/iam/AWSLoadBalancerController.json")
}

resource "aws_iam_role_policy_attachment" "load_balancer_policy_attachment" {
  role       = aws_iam_role.load_balancer.name
  policy_arn = aws_iam_policy.load_balancer_policy.arn
}

resource "aws_eks_pod_identity_association" "load_balancer" {
  cluster_name    = var.cluster_name
  namespace       = "kube-system"
  service_account = "aws-load-balancer-controller"
  role_arn        = aws_iam_role.load_balancer.arn
}

resource "helm_release" "load_balancer" {
  name = "aws-load-balancer"

  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.11.0"

  namespace = "kube-system"

  force_update = true

  values = [
    templatefile("${path.module}/templates/load_balancer.yaml",
      {
        cluster_name : var.cluster_name,
        service_account_name : "aws-load-balancer-controller",
        region : var.region,
        vpc_id : var.vpc_id
      }
    )
  ]
}
