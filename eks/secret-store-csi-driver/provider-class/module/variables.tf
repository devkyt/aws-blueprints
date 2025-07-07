variable "name" {
  description = "Name of the Secrets Provider Class"
  type        = string
}


variable "namespace" {
  description = "Namespace to use for the Secrets Provider Class"
  type        = string
}


variable "use_pod_identity" {
  description = "Whether to use pod identity for the Secrets Provider Class"
  type        = bool
  default     = false
}


variable "secrets" {
  description = "Secrets to use for the Secrets Provider Class"
  type = list(object({
    name = string
    arn  = string
    key  = string
  }))
}


variable "labels" {
  description = "Labels to attach to the resources"
  type        = map(string)
  default     = {}
}
