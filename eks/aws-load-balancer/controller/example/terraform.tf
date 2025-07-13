terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket  = "bucket"
    key     = "eks/aws-load-balancer/terraform.tfstate"
    region  = local.region
    encrypt = true
  }
}


provider "aws" {
  region = local.region
}


provider "helm" {
  kubernetes {
    host                   = local.cluster_endpoint
    cluster_ca_certificate = local.cluster_ca

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", local.cluster]
      command     = "aws"
    }
  }
}
