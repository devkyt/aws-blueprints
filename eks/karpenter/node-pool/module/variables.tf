variable "region" {
  description = "Region to use for the node pool"
  type        = string
  default     = "eu-central-1"
}


variable "class_name" {
  description = "Name of the node class"
  type        = string
  default     = "default"
}


variable "pool_name" {
  description = "Name of the node pool"
  type        = string
}


variable "arch" {
  description = "Architecture to use for the node pool"
  type        = list(string)
  default     = ["arm64"]
}


variable "instance_type" {
  description = "Instance type to use for the node pool"
  type        = list(string)
}


variable "capacity" {
  description = "Capacity to use for the node pool"
  type        = list(string)
}


variable "max_cpu" {
  description = "Maximum CPU to use for the node pool"
  type        = number
}

variable "max_memory" {
  description = "Maximum memory to use for the node pool"
  type        = string
}


variable "ttl" {
  description = "TTL to use for the node pool"
  type        = string
}


variable "disruption" {
  description = "Disruption to use for the node pool"
  type = object({
    policy         = string
    nodes_per_time = string
    after          = string
  })
  default = {
    policy         = "WhenEmptyOrUnderutilized"
    nodes_per_time = "1"
    after          = "10m"
  }
}


variable "labels" {
  description = "Labels to attach to the resources"
  type        = map(string)
  default     = {}
}
