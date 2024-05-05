terraform {
  required_version = "~> 1.7.4"

  backend "local" { path = "../../tfstate/fiap-irango-infra.tfstate" }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.43.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Environment = var.environment
      Service     = var.resource_prefix
    }
  }
}
