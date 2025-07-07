variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}


variable "chart_version" {
  type        = string
  description = "Version of the KEDA chart"
  default     = "2.14.0"
}


variable "node_selector" {
  description = "Labels on nodes where KEDA should be deployed"
  type        = map(string)
}


variable "tolerations" {
  description = "Tolerations for the KEDA deployment"
  type = list(object({
    key      = string
    operator = string
    value    = string
    effect   = string
  }))
}
