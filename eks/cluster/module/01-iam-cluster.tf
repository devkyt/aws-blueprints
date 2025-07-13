resource "aws_iam_role" "cluster" {
  name = "${var.cluster_name}-eks"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(local.tags,
    {
      Name = "${var.cluster_name}-eks"
      Type = "IAM Role"
    }
  )
}


data "aws_iam_policy" "cluster_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}


resource "aws_iam_role_policy_attachment" "cluster_policy_attachment" {
  policy_arn = data.aws_iam_policy.cluster_policy.arn
  role       = aws_iam_role.cluster.name
}
