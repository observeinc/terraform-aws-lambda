output "bucket" {
  description = "S3 bucket subscribed to Observe Lambda"
  value       = aws_s3_bucket.bucket
}
