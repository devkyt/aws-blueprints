module "vpc" {
  source = "../../module"

  env                = "dev"
  vpc_cidr           = "10.0.0.0/16"
  availability_zones = ["eu-central-1a", "eu-central-1b"]

  private_subnets = {
    # the number of cidr blocks must be equal to the number of availability zones
    cidr_blocks = ["10.0.0.0/19", "10.0.32.0/19"]
    tags = {
      Type = "private"
      # use these tags for private subnets if you are going to run EKS cluster in this VPC
      "kubernetes.io/role/internal-elb"  = "1"
      "kubernetes.io/cluster/mastermind" = "owned" # where mastermind is the cluster name (replace with your cluster name )
    }
  }

  public_subnets = {
    # the number of cidr blocks must be equal to the number of availability zones
    cidr_blocks = ["10.0.64.0/19", "10.0.96.0/19"]
    tags = {
      Type = "public"
      # use these tags for public subnets if you are going to run EKS cluster in this VPC
      "kubernetes.io/role/elb"           = "1"
      "kubernetes.io/cluster/mastermind" = "owned" # where mastermind is the cluster name (replace with your cluster name )
    }
  }

  # common tags for all resources
  tags = {
    Team = "Queens of the Stone Age"
  }
}
