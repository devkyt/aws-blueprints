output "vpc_id" {
  description = "The id of created VPC"
  value       = module.vpc.vpc_id
}


output "private_subnets_ids" {
  description = "The ids of created private subnets"
  value       = module.vpc.private_subnets_ids
}


output "public_subnets_ids" {
  description = "The ids of created public subnets"
  value       = module.vpc.public_subnets_ids
}
