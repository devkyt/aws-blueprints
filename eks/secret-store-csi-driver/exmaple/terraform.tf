terraform {
  backend "s3" {
    bucket = "bucket"
    region = local.region
    key    = "path/to/terraform.tfstate"
  }
}

provider "aws" {
  region = local.region
}


provider "helm" {
  kubernetes {
    host                   = local.cluster_endpoint
    cluster_ca_certificate = local.cluster_ca_certificate

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", local.cluster_name]
      command     = "aws"
    }
  }
}
