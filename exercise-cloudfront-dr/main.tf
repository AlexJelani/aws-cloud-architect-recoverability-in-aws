

Now let's create the Terraform files:

```hcl:aws-cloud-architect-recoverability-in-aws/exercise-cloudfront-dr/terraform/main.tf
provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

# Primary bucket in us-east-1
resource "aws_s3_bucket" "primary" {
  bucket = "dr-primary-${random_string.bucket_suffix.result}"
}

# Backup bucket in us-west-2
resource "aws_s3_bucket" "backup" {
  provider = aws.west
  bucket   = "dr-backup-${random_string.bucket_suffix.result}"
}

resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin_group {
    origin_id = "groupS3"

    failover_criteria {
      status_codes = [500, 502, 503, 504]
    }

    member {
      origin_id = "primaryS3"
    }

    member {
      origin_id = "backupS3"
    }
  }

  origin {
    domain_name = aws_s3_bucket.primary.bucket_regional_domain_name
    origin_id   = "primaryS3"
  }

  origin {
    domain_name = aws_s3_bucket.backup.bucket_regional_domain_name
    origin_id   = "backupS3"
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id      = "groupS3"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
