terraform {
  backend "s3" {
    bucket = "bucket"
    region = local.region
    key    = "path/to/terraform.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


provider "aws" {
  region = local.region
}
