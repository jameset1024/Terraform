# Create the web bucket
resource "aws_s3_bucket" "web_bucket" {
  bucket = var.bucket_name

  tags = var.tags
}

# Make the bucket public accessible
resource "aws_s3_bucket_public_access_block" "web_public_access" {
  bucket = aws_s3_bucket.web_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Point the web server to the correct file
resource "aws_s3_bucket_website_configuration" "web_config" {
  bucket = aws_s3_bucket.web_bucket.id

  index_document {
    suffix = var.index_file
  }

  error_document {
    key = var.error_file
  }
}

# Attach the bucket policy
resource "aws_s3_bucket_policy" "web_policy" {
  bucket = aws_s3_bucket.web_bucket.id
  policy = data.aws_iam_policy_document.web_policy.json
}

# Create the policy to allow public view
data "aws_iam_policy_document" "web_policy" {
  version = "2012-10-17"
  statement {
    sid = "AddPerm"
    effect = "Allow"
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.web_bucket.arn}/*"]
  }
}
