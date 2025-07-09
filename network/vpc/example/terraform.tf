terraform {
  backend "s3" {
    bucket = "bucket"
    region = "eu-central-1"
    key    = "vpc/terraform.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


provider "aws" {
  region = "eu-central-1"
}
