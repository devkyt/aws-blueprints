output "vpc_id" {
  description = "The id of created VPC"
  value       = aws_vpc.current.id
}


output "private_subnets_ids" {
  description = "The ids of created private subnets"
  value       = aws_subnet.private[*].id
}


output "public_subnets_ids" {
  description = "The ids of created public subnets"
  value       = aws_subnet.public[*].id
}
