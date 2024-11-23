# S3 Bucket Lifecycle Rule Exercise

This configuration creates an S3 bucket with an automated lifecycle rule that deletes objects after one day.

## Features
- S3 bucket creation
- Lifecycle rule configuration
- 1-day object expiration policy

## Deployment
1. Run `terraform init`
2. Run `terraform plan`
3. Run `terraform apply`

## Testing
Upload a test object to the bucket and verify it gets deleted after 24 hours.
