# DynamoDB Global Table Exercise

This exercise demonstrates setting up a DynamoDB Global Table across multiple AWS regions using Terraform.

## Configuration Details
- Primary Region: us-east-1
- Replica Region: us-east-2
- Table Name: my_dynamo_db
- Partition Key: course_id
- Billing Mode: PAY_PER_REQUEST

## Deployment Steps
1. Initialize Terraform: `terraform init`
2. Review changes: `terraform plan`
3. Deploy: `terraform apply`

## Verification
After deployment, verify the table and its replica through the AWS Console in both regions.
