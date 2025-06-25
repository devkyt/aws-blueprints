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


variable "pod_identity" {
  description = "Configuration for the Pod Identity"
  type = object({
    name     = string
    version  = string
    replicas = number
  })
  default = {
    name     = "coredns"
    version  = "v1.11.4-eksbuild.2"
    replicas = 3
  }
}


variable "core_dns" {
  description = "Configuration for the Core DNS"
  type = object({
    name     = string
    version  = string
    replicas = number
  })
  default = {
    name     = "coredns"
    version  = "v1.11.4-eksbuild.2"
    replicas = 3
  }
}


variable "ebs_csi_driver" {
  description = "Configuration for the EBS CSI driver"
  type = object({
    name                 = string
    version              = string
    service_account_name = string
  })
  default = {
    name                 = "aws-ebs-csi-driver"
    version              = "v1.41.0-eksbuild.1"
    service_account_name = "ebs-csi-controller-sa"
  }
}



variable "load_balancer" {
  description = "Configuration for the Load Balancer"
  type = object({
    name                 = string
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
