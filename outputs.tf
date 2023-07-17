output "lambda_function" {
  description = "Observe Lambda function"
  value       = aws_lambda_function.this
}

output "log_group_name" {
  description = "The name of the CloudWatch log group where logs for the Lambda will be written."
  value       = aws_cloudwatch_log_group.group.name
}
