variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}


variable "chart_version" {
  type        = string
  description = "Version of the KEDA chart"
  default     = "2.14.0"
}

variable "node_selector" {}


variable "tolerations" {}
