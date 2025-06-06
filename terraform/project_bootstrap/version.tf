terraform {
  # Terraform version constraint: https://www.terraform.io/language/settings#specifying-a-required-terraform-version
  required_version = "~> 1.2.7"

  # Providers & version:
  required_providers {
    # AWS provider & version constraint: https://registry.terraform.io/providers/hashicorp/aws/latest
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.93.0"
    }
  }
}
