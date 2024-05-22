provider "aws" {
    region = "ca-central-1"
}

resource "aws_s3_bucket" "terraform-bucket" {
    bucket = "veer-bucket-10111"
}

resource "aws_s3_bucket_versioning" "versioning_bucket" {
    bucket = aws_s3_bucket.terraform-bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
    name = "veer-db"
      
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}