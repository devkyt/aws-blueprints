terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket  = "bucket"
    key     = "path/to/terraform.tfstate"
    region  = local.region
    encrypt = true
  }
}


provider "aws" {
  region = local.region
}

