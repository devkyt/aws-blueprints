output "cluster_name" {
  description = "Cluster name"
  value       = aws_eks_cluster.cluster.name
}


output "cluster_endpoint" {
  description = "Cluster endpoint"
  value       = aws_eks_cluster.cluster.endpoint
}


output "cluster_ca_certificate" {
  description = "Cluster CA certificate"
  value       = base64decode(aws_eks_cluster.cluster.certificate_authority[0].data)
}


output "cluster_arn" {
  description = "Cluster ARN"
  value       = aws_eks_cluster.cluster.arn
}


output "cluster_vpc_id" {
  description = "Cluster VPC ID"
  value       = aws_eks_cluster.cluster.vpc_config[0].vpc_id
}


output "cluster_security_group_id" {
  description = "Cluster security group ID"
  value       = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
}


output "cluster_vpc_security_group_ids" {
  description = "Cluster VPC security group IDs"
  value       = aws_eks_cluster.cluster.vpc_config[0].security_group_ids
}


output "cluster_role_arn" {
  description = "Cluster role ARN"
  value       = aws_iam_role.cluster.arn
}


output "nodes_role_arn" {
  description = "Nodes role ARN"
  value       = aws_iam_role.nodes.arn
}
