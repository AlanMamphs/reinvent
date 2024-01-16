resource "aws_s3_bucket" "this" {
  bucket = var.name
}
resource "aws_s3_bucket_cors_configuration" "this" {
  count  = var.enable_cors ? 1 : 0
  bucket = aws_s3_bucket.this.id
  cors_rule {
    allowed_headers = var.cors_configuration.allowed_headers
    allowed_methods = var.cors_configuration.allowed_methods
    allowed_origins = var.cors_configuration.allowed_origins
    expose_headers  = var.cors_configuration.expose_headers
    max_age_seconds = var.cors_configuration.max_age_seconds
  }
}


resource "aws_s3_bucket_versioning" "this" {
  count  = var.enable_versioning ? 1 : 0
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}


output "id" {
  value       = aws_s3_bucket.this.id
  description = "The id of the s3 bucket"
}

output "arn" {
  value       = aws_s3_bucket.this.arn
  description = "The arn of the s3 bucket"
}

output "regional_domain_name" {
  value       = aws_s3_bucket.this.bucket_regional_domain_name
  description = "The arn of the s3 bucket"
}
