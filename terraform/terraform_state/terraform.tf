terraform {
    required_version = ">= 0.13"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "5.47.0"
        }
    }

    backend "s3" {
        bucket = "veer-bucket-10111"
        region = "ca-central-1"
        key = "terraform/data/terraform.tf"

        dynamodb_table = "veer-db"
    }
}
