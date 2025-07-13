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
  description = "Name of the cluster"
  type        = string
}


variable "vpc_id" {
  description = "ID of the cluster's VPC"
  type        = string
}


variable "namespace" {
  description = "Namespace to deploy the addons"
  type        = string
  default     = "kube-system"
}


variable "pod_identity_addon" {
  description = "Configuration for the Pod Identity"
  type = object({
    version = string
  })
  default = {
    version = "v1.3.7-eksbuild.2"
  }
}


variable "core_dns_addon" {
  description = "Configuration for the Core DNS"
  type = object({
    version  = string
    replicas = number
    tolerations = list(object({
      key      = string
      operator = string
      value    = string
      effect   = string
    }))
    node_selector = map(string)
  })
  default = {
    version       = "v1.11.4-eksbuild.14"
    replicas      = 3
    tolerations   = []
    node_selector = {}
  }
}


variable "ebs_csi_driver_addon" {
  description = "Configuration for the EBS CSI driver"
  type = object({
    version              = string
    service_account_name = string
    tolerations = list(object({
      key      = string
      operator = string
      value    = string
      effect   = string
    }))
    node_selector = map(string)
  })
  default = {
    version              = "v1.45.0-eksbuild.2"
    service_account_name = "ebs-csi-controller-sa"
    tolerations          = []
    node_selector        = {}
  }
}


variable "tags" {
  description = "Tags to attach to the created resources"
  type        = map(string)
  default     = {}
}
