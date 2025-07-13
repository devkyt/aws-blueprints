variable "env" {
  description = "Target environment name"
  type        = string
  default     = "dev"
}


variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}


variable "cluster" {
  description = "The name of the EKS cluster"
  type        = string
}


variable "module_version" {
  description = "Karpenter version"
  type        = string
  default     = "20.36.0"
}


variable "chart_version" {
  description = "Karpenter Helm Chart version"
  type        = string
  default     = "1.4.0"
}


variable "namespace" {
  description = "Namespace where Karpenter will operate"
  type        = string
  default     = "karpenter"
}


variable "node_selector" {
  description = "Node selector for the Karpenter"
  type        = map(string)
  default     = {}
}


variable "tolerations" {
  description = "Tolerations for the Karpenter"
  type = list(object({
    key      = string
    operator = string
    value    = string
    effect   = string
  }))
  default = []
}


variable "iam_role_name" {
  type        = string
  description = "Name of the IAM role for the Karpenter"
  default     = "karpenter"
}


variable "iam_role_additional_policies" {
  type        = map(string)
  description = "Additional policies to be attached to the Karpenter IAM role"
  default     = {}
}


variable "node_classes" {
  description = "Configuration for Node Classes managed by Karpenter"
  type = list(object({
    name = string
    ami  = string
  }))
  default = [
    {
      name = "default"
      ami  = "ami-00a61821236f192f0"
    }
  ]
}


variable "node_pools" {
  description = "Configuration for Node Pools managed by Karpenter"
  type = list(object({
    class_name    = string
    pool_name     = string
    arch          = list(string)
    instance_type = list(string)
    capacity      = list(string)
    max_cpu       = number
    max_memory    = string
    ttl           = string
    disruption = object({
      policy         = string
      nodes_per_time = string
      after          = string
    })
  }))
}


variable "tags" {
  type        = map(string)
  description = "Tags to attach to the created resources"
}
