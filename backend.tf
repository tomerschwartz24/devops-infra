terraform {
  backend "s3" {
    bucket = "remotestatetomer"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}
