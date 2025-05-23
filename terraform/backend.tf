terraform {
  backend "s3" {
    bucket         = "chating-app-project-state-tf"
    key            = "eks/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
