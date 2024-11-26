# Lambda CloudWatch Monitoring Exercise

This exercise demonstrates how to set up AWS Lambda monitoring using CloudWatch.

## Features
- Lambda function deployment
- CloudWatch Logs configuration
- Basic execution role setup
- Metrics monitoring capability

## Prerequisites
- AWS CLI configured
- Terraform installed
- Basic Node.js knowledge

## Deployment Steps
1. Create a simple Lambda function in `index.js`
2. Zip the Lambda function: `zip lambda_function.zip index.js`
3. Run `terraform init`
4. Run `terraform plan`
5. Run `terraform apply`

## Monitoring
After deployment, you can monitor the Lambda function through CloudWatch:
- Execution metrics
- Error rates
- Duration statistics
- Memory usage

## Cleanup
Run `terraform destroy` to remove all created resources
