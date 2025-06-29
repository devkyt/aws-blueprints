variable "env" {
  description = "Target environment name"
  type        = string
  default     = "dev"
}


variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = ""
}


variable "vpc_cidr" {
  description = "CIDR (Classless Inter-Domain Routing) block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}


variable "availability_zones" {
  description = "Availability zones for the subnets"
  type        = list(string)
}


variable "private_subnets" {
  description = "Private subnets configuration"
  type = object({
    cidr_blocks = list(string)
    tags        = map(string)
  })
}


variable "public_subnets" {
  description = "Public subnets configuration"
  type = object({
    cidr_blocks = list(string)
    tags        = map(string)
  })
}


variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {}
}
