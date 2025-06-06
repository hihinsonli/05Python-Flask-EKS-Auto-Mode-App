variable "bucket_name" {
  description = "(Required) The name of the bucket."
  type        = string
  validation {
    condition     = var.bucket_name != ""
    error_message = "The bucket_name value must be provided."
  }
}

variable "cloudfront_oai_iam_arn" {
  description = "(Optional) A pre-generated ARN for use in S3 bucket policies."
  default     = null
  type        = string
}

variable "cloudfront_distribution_arn" {
  description = "(Optional) The ARN of the CloudFront distribution."
  default     = null
  type        = string
}

variable "is_cloudfront_bucket" {
  description = "Whether this bucket is used with CloudFront (applies CloudFront OAI policy)"
  type        = bool
  default     = false
}

variable "state_bucket_policy" {
  description = "(Optional) policy for Terraform state bucket (if not CloudFront bucket)"
  type        = string
  default     = ""
}

variable "environment" {
  description = "(Optional) Environment name for tagging"
  type        = string
  default     = ""
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A map of tags (key-value) to assign to resources managed by this module."
}
