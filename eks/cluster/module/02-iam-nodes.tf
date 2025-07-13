resource "aws_iam_role" "nodes" {
  name = "${var.cluster_name}-nodes"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(local.tags,
    {
      Name = "${var.cluster_name}-nodes"
      Type = "IAM Role"
    }
  )
}


data "aws_iam_policy" "worker_node_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}


resource "aws_iam_role_policy_attachment" "worker_node_policy_attachment" {
  policy_arn = data.aws_iam_policy.worker_node_policy.arn
  role       = aws_iam_role.nodes.name
}


data "aws_iam_policy" "eks_cni_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}


resource "aws_iam_role_policy_attachment" "eks_cni_policy_attachment" {
  policy_arn = data.aws_iam_policy.eks_cni_policy.arn
  role       = aws_iam_role.nodes.name
}


data "aws_iam_policy" "ecr_readonly_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}


resource "aws_iam_role_policy_attachment" "ecr_readonly_policy_attachment" {
  policy_arn = data.aws_iam_policy.ecr_readonly_policy.arn
  role       = aws_iam_role.nodes.name
}
