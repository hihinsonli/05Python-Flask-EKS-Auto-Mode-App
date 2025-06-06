# S3 Bucket
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
}

# S3 Bucket Ownership Controls
resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# S3 Bucket Public Access Block
resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3 Bucket Policy for CloudFront Access
# When creating terraform state bucket, is_cloudfront_bucket is false
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.this.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = concat(
      # CloudFront OAI policy (only for CloudFront buckets)
      var.is_cloudfront_bucket ? [
        {
          Sid       = "AllowCloudFrontOAI"
          Effect    = "Allow"
          Principal = { AWS = var.cloudfront_oai_iam_arn }
          Action    = "s3:GetObject"
          Resource  = "${aws_s3_bucket.this.arn}/*"
        }
      ] : [],
      # Custom policy for state bucket (if provided)
      var.state_bucket_policy != "" ? jsondecode(var.state_bucket_policy).Statement : []
    )
  })
}
