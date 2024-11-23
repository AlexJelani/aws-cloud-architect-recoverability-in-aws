provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "replica"
  region = "us-east-2"
}

resource "aws_dynamodb_table" "my_dynamo_db" {
  name           = "my_dynamo_db"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "course_id"
  stream_enabled = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "course_id"
    type = "S"
  }

  replica {
    region_name = "us-east-2"
  }
}
