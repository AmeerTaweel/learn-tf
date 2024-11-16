terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.74.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region     = var.aws-region
  access_key = var.aws-access-key
  secret_key = var.aws-secret-key
}
