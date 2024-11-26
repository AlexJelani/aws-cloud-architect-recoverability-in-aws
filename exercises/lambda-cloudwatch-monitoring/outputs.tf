
output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.test_lambda.function_name
}

output "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.lambda_log_group.name
}
