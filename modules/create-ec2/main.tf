provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "east2"
  region = "us-east-2"
}

/*
data "aws_ami" "ubuntu" {

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
*/

resource "aws_instance" "example" {
  count = 3
  ami           = "ami-0e5497a77ef21b5ac"
  instance_type = var.instance_type
  provider = aws.east2

  tags = {
    Name = "east-2-prod-instance-${count.index}"
  }
}

variable "instance_type" {}
