terraform {
  backend "s3" {
    bucket         = "helloword-terraform-state-bucket"
    key            = "terraform/state/tfstate"
    region         = "us-east-1"
  }
}