terraform {
  required_version = ">= 1.7.4, <= 1.8.1"

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
}
