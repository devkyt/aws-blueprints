terraform {
  backend "s3" {
    bucket = "bucket"
    key    = "path/to/terraform.tfstate"
    region = local.region
  }
}

provider "aws" {
  region = local.region
}
