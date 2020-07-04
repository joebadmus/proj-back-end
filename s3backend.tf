
provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "java-infra-dev-backend" {
  bucket = "joebadmus-dev-s3-backend"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
