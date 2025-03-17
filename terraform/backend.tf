terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}

