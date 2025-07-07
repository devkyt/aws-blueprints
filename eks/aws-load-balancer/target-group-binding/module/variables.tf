variable "name" {
  description = "Name of the target group binding"
  type        = string
  default     = null
}


variable "service" {
  description = "Service to bind to the target group"
  type = object({
    name      = string
    namespace = string
    port      = number
  })
}


variable "target_group_arn" {
  description = "ARN of the target group to which the service will be bound"
  type        = string
}


variable "labels" {
  description = "Labels to add to the resources"
  type        = map(string)
  default     = {}
}
