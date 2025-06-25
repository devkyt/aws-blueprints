provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "local" {
    path = "aws/network/vpc/examples/state/terraform.tfstate"
  }
}
