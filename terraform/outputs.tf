output "website_endpoint" {
  value = "http://${aws_s3_bucket.website.bucket}.s3-website-${data.aws_region.current.name}.amazonaws.com"
}
