resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = "terraform-state-lock-dynamo"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "DynamoDB Terraform State Lock Table"
    Environment = "dev"
  }
}


terraform {
  backend "s3" {
    bucket         = "joebadmus-proj-dev-backend"
    key            = "infra/lock/terraform.tfstate"
    dynamodb_table = "terraform-state-lock-dynamo"
    region         = "eu-west-2"
  }
}
