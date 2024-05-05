terraform {
  required_version = ">= 1.7.4, <= 1.8.1"

  backend "s3" {
    bucket = "fiap-irango-tfstate"
    key    = "fiap-irango-infra.tfstate"
    region = "us-east-1"
  }

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

# Test Terraform Plan