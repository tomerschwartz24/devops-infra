
terraform {
  required_version = ">=v1.4.5"
  backend "s3" {
    bucket = "bucketof-tfstates"
    key    = "workflows/app/terraform.tfstate"

  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.63.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.5.1"
    }
  }
}
