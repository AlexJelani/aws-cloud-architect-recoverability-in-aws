
provider "aws" {
  region = var.aws_region
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_monitoring_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}

resource "aws_lambda_function" "test_lambda" {
  filename      = "lambda_function.zip"
  function_name = "monitoring_test_function"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"

  environment {
    variables = {
      ENVIRONMENT = "test"
    }
  }
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.test_lambda.function_name}"
  retention_in_days = 14
}

resource "aws_cloudwatch_metric_alarm" "lambda_invocations" {
  alarm_name          = "lambda-invocations-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "Invocations"
  namespace          = "AWS/Lambda"
  period             = "60"
  statistic          = "Sum"
  threshold          = "1"
  alarm_description  = "This metric monitors lambda function invocations"
  
  dimensions = {
    FunctionName = aws_lambda_function.test_lambda.function_name
  }
}
