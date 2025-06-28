resource "helm_release" "load_balancer" {
  name = "aws-load-balancer"

  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = var.load_balancer.version

  namespace = "kube-system"

  force_update = true

  values = [templatefile("${path.module}/charts/lb.values.yaml",
    {
      cluster_name : var.cluster_name,
      service_account_name : var.load_balancer.service_account_name,
      region : var.region,
      vpc_id : var.vpc_id
    }
    )
  ]
}


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
      Name = "${var.cluster_name}-load-balancer"
      Type = "IAM Role"
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
  service_account = var.load_balancer.service_account_name
  role_arn        = aws_iam_role.load_balancer.arn

  tags = merge(local.tags,
    {
      Name           = "${var.load_balancer.service_account_name}-pod-identity"
      Type           = "Pod Identity Association"
      ServiceAccount = var.load_balancer.service_account_name
      Role           = aws_iam_role.load_balancer.name
    }
  )
}



