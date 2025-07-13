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


variable "vpc_id" {
  description = "ID of the cluster's VPC"
  type        = string
}


variable "cluster" {
  description = "Name of the cluster"
  type        = string
}


variable "namespace" {
  description = "Namespace where Load Balancer Controller will operate"
  type        = string
  default     = "kube-system"
}


variable "chart_version" {
  description = "Helm chart version of the load balancer controller"
  type        = string
  default     = "1.13.3"
}


variable "release_name" {
  description = "Name of the Helm release"
  type        = string
  default     = "aws-load-balancer"
}


variable "service_account" {
  description = "Name of the service account for the Load Balancer Controller"
  type        = string
}


variable "node_selector" {
  description = "Node selector for the Load Balancer Controller"
  type        = map(string)
  default     = {}
}


variable "tolerations" {
  description = "Tolerations for the Load Balancer Controller"
  type = list(object({
    key      = string
    operator = string
    value    = string
    effect   = string
  }))
  default = []
}


variable "tags" {
  description = "Tags to attach to the resources"
  type        = map(string)
  default     = {}
}
