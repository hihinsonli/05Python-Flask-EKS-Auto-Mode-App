# S3 Bucket for Terraform State
module "s3_terraform_state" {
  source               = "../modules/s3"
  bucket_name          = var.state_bucket_name
  is_cloudfront_bucket = false
  state_bucket_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowGitHubActions"
        Effect = "Allow"
        Principal = {
          AWS = [
            "arn:aws:iam::${var.account_number}:role/GitHubActionsRole"
          ]
        }
        Action = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
        Resource = [
          "arn:aws:s3:::${var.state_bucket_name}",
          "arn:aws:s3:::${var.state_bucket_name}/*"
        ]
      }
    ]
  })
  environment = var.environment
}
