resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.website.id
  key          = "index.html"
  source       = "../s3/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "winter_image" {
  bucket       = aws_s3_bucket.website.id
  key          = "winter.jpg"
  source       = "../s3/winter.jpg"
  content_type = "image/jpeg"
}