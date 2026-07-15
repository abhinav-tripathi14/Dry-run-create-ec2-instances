terraform { 
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.89.0"
    }
  }
   cloud {
   organization = "Test-Abhinav"
   workspaces {
      name = "prod-ec2-instances"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}

module "create-ec2" {
  source     = "./modules/create-ec2"
  instance_type = "t3.micro"
  providers = {
    aws = aws.east2
  }
}
