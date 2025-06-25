variable "env" {
  type        = string
  description = "Target environment name"
  default     = "dev"
}

variable "region" {
  type        = string
  description = "AWS region"
  default     = "eu-central-1"
}


variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}


variable "karpenter" {
  description = "Configuration for Karpenter autoscaler"
  type = object({
    module_version = string
    chart_version  = string
    namespace      = string
    iam_role_name  = string
    node_selector  = map(string)
    tolerations = list(object({
      key      = string
      operator = string
      value    = string
      effect   = string
      })
    )
  })
  default = {
    module_version = "20.36.0"
    chart_version  = "1.4.0"
    namespace      = "karpenter"
    node_selector = {
      control = "true"
    }
    tolerations = [{
      key      = "control"
      operator = "Equal"
      value    = "true"
      effect   = "NoSchedule"
    }]
  }
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
