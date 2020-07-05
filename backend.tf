provider "aws" {
  region  = "eu-west-2"
  profile = "default"
}

terraform {
  backend "s3" {
    bucket         = "joebadmus-proj-dev-backend"
    key            = "infra/network/terraform.tfstate"
    dynamodb_table = "terraform-state-lock-dynamo"
    region         = "eu-west-2"
  }
}
