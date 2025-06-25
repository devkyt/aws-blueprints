variable "name" {
  description = "Private link name"
  type        = string
  default     = "private-link"
}


variable "env" {
  description = "Target environment name"
  type        = string
  default     = "dev"
}


variable "aws_provider" {
  type = object({
    vpc_id      = string
    cidr_block  = string
    subnets_ids = list(string)
  })
}


variable "aws_consumer" {
  type = object({
    vpc_id      = string
    cidr_block  = string
    subnets_ids = list(string)
  })
}


variable "application_load_balancer" {
  type = object({
    name       = string
    keep_alive = number
    target_group = object({
      name = string
      port = number
      health_check = object({
        path                = string
        interval            = number
        timeout             = number
        healthy_threshold   = number
        unhealthy_threshold = number
      })
    })
  })
}


variable "network_load_balancer" {
  type = object({
    name              = string
    port              = number
    keep_alive        = number
    allow_cidr_blocks = list(string)
  })
}


variable "domain" {
  description = "Domain name for private link"
  type        = string
}


variable "subdomains" {
  description = "Subdomains to attach to the private link"
  type        = list(string)
}


variable "certificate_arn" {
  type        = string
  description = "ARN of the certificate to use for the Load Balancer listeners"
}


variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
