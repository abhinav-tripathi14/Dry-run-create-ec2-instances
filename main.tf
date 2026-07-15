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

provider "aws" {
  alias  = "east2"
  region = "us-east-2"
}

module "create-ec2" {
  source     = "./modules/create-ec2"
  instance_type = "t3.micro"
  providers = {
    aws.east2 = aws.east2
  }
}

variable "resources_to_create" {
  default = {
    count =2
  }
}

resource "aws_instance" "root_instances" {
  count = var.resources_to_create.count
  ami           = "ami-0e5497a77ef21b5ac"
  instance_type = "t3.micro"

  tags = {
    Name = "root-instance-${count.index}"
  }
}