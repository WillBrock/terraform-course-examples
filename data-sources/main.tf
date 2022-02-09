terraform {
	required_providers {
		aws = {
			source  = "hashicorp/aws"
			version = "~> 3.74"
		}
	}
}

provider "aws" {
	region = "us-west-2"
}

# resource "aws_instance" "web" {
# 	ami           = data.aws_ami.ubuntu.id
# 	instance_type = "t2.micro"
# }

data "aws_ami" "ubuntu" {
	most_recent = true
	owners      = ["self"]

	filter {
		name = "name"
		values = ["tuts-ubuntu"]
	}
}

data "aws_vpc" "foo" {
	default = true
}

data "aws_vpc" "main" {
	filter {
		name  = "tag:Name"
		values = ["will-vpc"]
	}
}

output "vpc" {
	value = data.aws_vpc.foo
}
