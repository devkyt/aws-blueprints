variable "namespace" {
  description = "Namespace to deploy the Secret Store CSI Driver and AWS Secret Store CSI Provider"
  type        = string
  default     = ""
}


variable "secrets_store_csi_driver" {
  description = "Release configuration for the Secret Store CSI Driver"
  type = object({
    chart_version = string
    namespace     = optional(string)
  })
  default = {
    chart_version = "1.5.1"
    namespace     = "secrets-store"
  }
}


variable "secrets_store_csi_driver_resources" {
  description = "Resources allocation for the Secret Store CSI Driver"
  type = object({
    limits = object({
      cpu    = string
      memory = string
    })
    requests = object({
      cpu    = string
      memory = string
    })
  })
  default = {
    limits = {
      cpu    = "200m"
      memory = "200Mi"
    }
    requests = {
      cpu    = "200m"
      memory = "200Mi"
    }
  }
}


variable "secrets_store_csi_provider_aws" {
  description = "Release configuration for the AWS Secret Store CSI Provider"
  type = object({
    chart_version = string
    namespace     = optional(string)
  })
  default = {
    chart_version = "1.0.1"
    namespace     = "secrets-store"
  }
}


variable "secrets_store_csi_provider_aws_resources" {
  description = "Resources allocation for the AWS Secret Store CSI Provider"
  type = object({
    limits = object({
      cpu    = string
      memory = string
    })
    requests = object({
      cpu    = string
      memory = string
    })
  })
  default = {
    limits = {
      cpu    = "200m"
      memory = "200Mi"
    }
    requests = {
      cpu    = "200m"
      memory = "200Mi"
    }
  }
}
