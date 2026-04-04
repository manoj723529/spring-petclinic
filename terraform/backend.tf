terraform {
  required_version = ">= 1.0"

  backend "s3" {
    bucket         = "petclinic-terraform-state"
    key            = "eks/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true

    dynamodb_table = "terraform-lock-table"
  }
}
