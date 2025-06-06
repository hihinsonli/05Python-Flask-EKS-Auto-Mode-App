variable "account_number" {
  description = "(Required) The AWS account number to use for IAM role and user ARNs"
  type        = string
}

variable "aws_region" {
  description = "(Optional) AWS region"
  type        = string
  default     = "ap-southeast-2"
}

variable "state_bucket_name" {
  description = "(Required) Name of the S3 bucket for Terraform state"
  type        = string
}

variable "environment" {
  description = "(Optional) Environment name for tagging"
  type        = string
  default     = ""
}
