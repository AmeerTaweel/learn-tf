terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.74.0"
    }
  }

  cloud {
    organization = "future-gadget-lab"
    hostname = "app.terraform.io"
    workspaces {
      name = "workspace-001"
    }
  }
}

provider "aws" {
  # Configuration options
  region     = var.aws-region
  access_key = var.aws-access-key
  secret_key = var.aws-secret-key
}
