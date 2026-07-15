terraform { 
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.31.0"
    }
  }
   cloud {
   organization = "Test-Abhinav"
   workspaces {
      name = "prod-ec2-instances"
    }
  }
}


variable "root_instance_names" {
  default = {
    instance_1 = {
       name = "root_instance_1"
    },
    instance_2 = {
      name = "root_instance_2"
    }
  }
}

resource "aws_instance" "root_instances" {
  for_each = var.root_instance_names
  ami           = "ami-022ba4d2b25fcb11c"
  instance_type = "t4g.micro"

  tags = {
    Name = each.value.name
  }
}