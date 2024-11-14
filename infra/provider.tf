terraform {
  required_version = ">= 1.9"  # Krever minst versjon 1.9 av Terraform
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.74.0"  # Bruker AWS-provider versjon 5.74.0.
    }
  }
  
  #s3 bucket backend for å lagre tfstate filen
  backend "s3" {
    bucket         = "pgr301-2024-terraform-state"
    key            = "infra/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
  }
}

#provider for å opprette ressurser i aws eu-west-1
provider "aws" {
  region = "eu-west-1"
}