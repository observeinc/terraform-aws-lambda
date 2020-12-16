output "bucket_id" {
  description = "ID for S3 bucket containing CloudTrail logs"
  value       = module.cloudtrail_s3_bucket.bucket_id
}
