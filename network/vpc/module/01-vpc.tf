resource "aws_vpc" "current" {
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.common_tags,
    {
      Name = coalesce(var.vpc_name, "${var.env}-vpc")
      Type = "VPC"
    }
  )
}
