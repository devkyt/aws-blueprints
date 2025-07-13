data "aws_vpc" "current" {
  tags = {
    Env  = local.env
    Name = "mastermind-vpc"
  }
}


data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.current.id]
  }

  tags = {
    Env                      = local.env
    "karpenter.sh/discovery" = "dev"
  }
}
