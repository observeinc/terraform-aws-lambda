output "id" {
  description = "S3 Bucket ID"
  value       = module.s3_bucket.s3_bucket_id
}

output "arn" {
  description = "S3 Bucket ARN"
  value       = module.s3_bucket.s3_bucket_arn
}
