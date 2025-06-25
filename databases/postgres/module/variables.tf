variable "env" {
  description = "Target environment"
  type        = string
}


variable "service" {
  description = "Name of a service that requires database"
  type        = string
}


variable "database_name" {
  description = "Name of the database"
  type        = string
}


variable "vpc_id" {
  description = "ID of the VPC where database will be located"
  type        = string
}


variable "subnet_ids" {
  description = "IDs of subnets to where database will be located"
  type        = list(string)
}


variable "availability_zone" {
  description = "In which availability zone to run the database"
  type        = string
  default     = "eu-central-1a"
}


variable "instance_type" {
  description = "What instance types to use for the database"
  type        = string
  default     = "db.t4g.small"
}


variable "postgres_version" {
  description = "value"
  type        = string
  default     = "17.4"
}


variable "storage" {
  description = "Configuration for the database storage"
  type = object({
    type      = string
    encrypted = bool
    size      = string
  })
  default = {
    type      = "gp2"
    encrypted = true
    size      = 50
  }
}


variable "network_rules" {
  description = "Configuration for the database network rules"
  type = object({
    port                    = number
    protocol                = string
    allowed_security_groups = list(string)
    public                  = bool
  })
}


variable "maintenance" {
  description = "Configuration for the database maintenance"
  type = object({
    window                     = string
    auto_minor_version_upgrade = bool
  })
  default = {
    window                     = "sat:18:30-sat:19:00"
    auto_minor_version_upgrade = true
  }
}


variable "backup" {
  description = "Configuration for the database backup"
  type = object({
    window    = string
    retention = string
  })
  default = {
    window    = "22:30-23:00"
    retention = "2"
  }
}


variable "monitoring_role_arn" {
  description = "ARN of the role that will be used to monitor the database"
  type        = string
}


variable "tags" {
  description = "Tags attached to managed AWS resources"
  type        = map(string)
  default     = {}
}
