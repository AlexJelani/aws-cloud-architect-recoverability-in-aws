provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "lifecycle_bucket" {
  bucket = "my-lifecycle-bucket-demo"
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle" {
  bucket = aws_s3_bucket.lifecycle_bucket.id

  rule {
    id     = "delete_after_one_day"
    status = "Enabled"

    expiration {
      days = 1
    }
  }
}
