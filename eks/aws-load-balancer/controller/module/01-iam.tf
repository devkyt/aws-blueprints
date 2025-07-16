data "aws_iam_policy_document" "current" {
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


resource "aws_iam_role" "current" {
  name               = "${var.cluster}-load-balancer"
  assume_role_policy = data.aws_iam_policy_document.current.json

  tags = merge(local.tags,
    {
      Name = "${var.cluster}-load-balancer"
      Type = "IAM Role"
    }
  )
}


resource "aws_iam_policy" "current" {
  name   = "AWSLoadBalancerController"
  policy = file("${path.module}/policies/LoadBalancerController.json")
}


resource "aws_iam_role_policy_attachment" "current" {
  role       = aws_iam_role.current.name
  policy_arn = aws_iam_policy.current.arn
}


resource "aws_eks_pod_identity_association" "current" {
  cluster_name    = var.cluster
  namespace       = "kube-system"
  service_account = var.service_account
  role_arn        = aws_iam_role.current.arn

  tags = merge(local.tags,
    {
      Name           = "${var.service_account}-pod-identity"
      Type           = "Pod Identity Association"
      ServiceAccount = var.service_account
      Role           = aws_iam_role.current.name
    }
  )
}



