# Naming
variable "environment" {
  default = "studying"
}

variable "resource_prefix" {
  default = "fiap-irango"
}

variable "region" {
  default = "us-east-1"
}

variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "default_az" {
  default = "us-east-1a"
}

# Outputs for variables
output "environment" {
  value = var.environment
}

output "resource_prefix" {
  value = var.resource_prefix
}

output "region" {
  value = var.region
}

output "availability_zones" {
  value = var.availability_zones
}

output "default_az" {
  value = var.default_az
}
