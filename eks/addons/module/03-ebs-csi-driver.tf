resource "aws_eks_addon" "ebs_csi_driver" {
  addon_name                  = "aws-ebs-csi-driver"
  addon_version               = var.ebs_csi_driver_addon.version
  cluster_name                = var.cluster
  resolve_conflicts_on_create = "OVERWRITE"

  service_account_role_arn = aws_iam_role.ebs_csi_driver.arn

  configuration_values = jsonencode({
    controller = {
      tolerations  = var.ebs_csi_driver_addon.tolerations
      nodeSelector = var.ebs_csi_driver_addon.node_selector
    }
    node = { tolerateAllTaints : true }
  })

  tags = merge(local.tags,
    {
      Name  = "${var.cluster}-ebs-csi-driver"
      Type  = "EBS CSI Driver"
      Addon = true
    }
  )
}


data "aws_iam_policy_document" "ebs_csi_driver" {
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


resource "aws_iam_role" "ebs_csi_driver" {
  name               = "${var.cluster}-ebs-csi-driver"
  assume_role_policy = data.aws_iam_policy_document.ebs_csi_driver.json

  tags = merge(local.tags,
    {
      Name = "${var.cluster}-ebs-csi-driver"
      Type = "IAM Role"
    }
  )
}


data "aws_iam_policy" "ebs_csi_driver_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}


resource "aws_iam_role_policy_attachment" "ebs_csi_driver_policy_attachment" {
  policy_arn = data.aws_iam_policy.ebs_csi_driver_policy.arn
  role       = aws_iam_role.ebs_csi_driver.name
}


# Encrypt EBS drives
resource "aws_iam_policy" "ebs_csi_driver_encryption_policy" {
  name = "${var.cluster}-ebs-csi-driver-encryption"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt",
          "kms:GenerateDataKeyWithoutPlaintext",
          "kms:CreateGrant"
        ],
        Resource = "*"
      }
    ]
  })

  tags = merge(local.tags,
    {
      Name    = "${var.cluster}-ebs-csi-driver-encryption"
      Type    = "IAM Policy"
      Cluster = var.cluster
    }
  )
}


resource "aws_iam_role_policy_attachment" "ebs_csi_driver_encryption_policy_attachment" {
  policy_arn = aws_iam_policy.ebs_csi_driver_encryption_policy.arn
  role       = aws_iam_role.ebs_csi_driver.name
}


resource "aws_eks_pod_identity_association" "ebs_csi_driver_identity" {
  cluster_name    = var.cluster
  namespace       = "kube-system"
  service_account = var.ebs_csi_driver_addon.service_account_name
  role_arn        = aws_iam_role.ebs_csi_driver.arn

  tags = merge(local.tags,
    {
      Name           = "${var.ebs_csi_driver_addon.service_account_name}-pod-identity"
      Type           = "Pod Identity Association"
      ServiceAccount = var.ebs_csi_driver_addon.service_account_name
      Role           = aws_iam_role.ebs_csi_driver.name
    }
  )
}



