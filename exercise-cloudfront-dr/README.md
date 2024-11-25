# CloudFront Disaster Recovery Exercise

This exercise demonstrates setting up a CloudFront distribution with multi-region S3 bucket failover.

## Architecture

- Primary S3 bucket in us-east-1
- Backup S3 bucket in us-west-2
- CloudFront distribution with origin group configuration
- Origin group failover between primary and backup buckets

## Prerequisites

- AWS CLI configured
- Terraform installed
- AWS account with appropriate permissions

## Deployment

1. Initialize Terraform:
```bash
terraform init
