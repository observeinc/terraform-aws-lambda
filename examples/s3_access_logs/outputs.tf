output "monitored" {
  description = "S3 bucket monitored with access logs"
  value       = aws_s3_bucket.monitored
}
