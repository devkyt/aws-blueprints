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


variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}


variable "vpc_id" {
  description = "ID of the cluster's VPC"
  type        = string
}


variable "pod_identity_addon" {
  description = "Configuration for the Pod Identity"
  type = object({
    version = string
  })
  default = {
    version = "v1.2.0-eksbuild.1"
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
    version       = "v1.11.4-eksbuild.2"
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
    version              = "v1.41.0-eksbuild.1"
    service_account_name = "ebs-csi-controller-sa"
    tolerations          = []
    node_selector        = {}
  }
}



variable "load_balancer_addon" {
  description = "Configuration for the Load Balancer"
  type = object({
    version              = string
    service_account_name = string
  })
  default = {
    name                 = "aws-ebs-csi-driver"
    version              = "v1.41.0-eksbuild.1"
    service_account_name = "ebs-csi-controller-sa"
  }
}



variable "tags" {
  description = "Tags to attach to the created resources"
  type        = map(string)
  default     = {}
}
