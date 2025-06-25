variable "env" {
  description = "Target environment name"
  type        = string
}

variable "name" {
  description = "Application load balancer name"
  type        = string
}


variable "vpc_id" {
  description = "Id of the VPC where load balancer will be located"
  type        = string
}


variable "subnets_ids" {
  description = "Ids of the subnets where load balancer will be located"
  type        = list(string)
}


variable "target_group" {
  description = "Configuration of target group to attach to load balancer"
  type = object({
    create = bool
    name   = string
    port   = number
    arn    = optional(string)
    health_check = object({
      path                = string
      interval            = number
      timeout             = number
      healthy_threshold   = number
      unhealthy_threshold = number
    })
  })
}


variable "certificate_arn" {
  description = "Arn of the certificate to use for HTTPS listener"
  type        = string
}


variable "auth0" {
  description = "Setup for OIDC authentication"
  type = object({
    domain        = string
    client_id     = string
    client_secret = string
  })
  nullable = true
  default  = null
}


variable "tags" {
  description = "Tags to apply to the load balancer and related resources"
  type        = map(string)
  default     = {}
}



