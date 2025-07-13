variable "env" {
  description = "Target environment"
  type        = string
  default     = "dev"
}


variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}


variable "cluster_name" {
  description = "Cluster name"
  type        = string
  default     = "mastermind"
}


variable "cluster_version" {
  description = "Kubernetes version for the cluster"
  type        = string
  default     = "1.31"
}


variable "vpc_id" {
  description = "ID of VPC where cluster will be located"
  type        = string
}


variable "private_subnets_ids" {
  description = "Private subnets where cluster will be located"
  type        = list(string)
}


variable "security_groups_ids" {
  description = "Additional security groups that will have access to the cluster"
  type        = list(string)
  default     = []
}


variable "nodegroups" {
  description = "List of Node Groups to create"
  type = list(object({
    name          = string
    capacity_type = string
    ami_type      = string
    instance_type = string

    scaling_config = object({
      min_size     = number
      max_size     = number
      desired_size = number
    })

    max_unavailable_on_update = number

    labels = optional(map(string))

    taint = optional(object({
      key    = string
      value  = string
      effect = string
    }))
  }))

  validation {
    condition = alltrue([
      for group in var.nodegroups : contains(["SPOT", "ON_DEMAND"], group.capacity_type)
    ])
    error_message = "Node Group capacity type must be SPOT or ON_DEMAND"
  }

  validation {
    condition = alltrue([
      for group in var.nodegroups : group.taint != null ? contains(["NO_SCHEDULE", "NO_EXECUTE", "PREFER_NO_SCHEDULE"], group.taint.effect) : true
    ])
    error_message = "Node Group taint effect must be NO_SCHEDULE, NO_EXECUTE or PREFER_NO_SCHEDULE"
  }
}


variable "karpenter_discovery_tags" {
  description = "Tags that help Karpenter automatically discover the resources it needs"
  type        = map(string)
  default     = {}
}


variable "labels" {
  description = "Labels to attach to the all nodes in the cluster"
  type        = map(string)
  default     = {}
}


variable "tags" {
  description = "Tags to attach to the created resources"
  type        = map(string)
  default     = {}
}
