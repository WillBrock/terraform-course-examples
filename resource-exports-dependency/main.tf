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

resource "aws_instance" "web" {
	ami           = "ami-003634241a8fcdec0"
	instance_type = "t2.micro"
	subnet_id     = aws_subnet.main.id
}

resource "aws_vpc" "main" {
	cidr_block = "10.5.0.0/16"

	tags = {
		Name = "tuts-testing"
	}
}

resource "aws_subnet" "main" {
	vpc_id     = aws_vpc.main.id
	cidr_block = "10.5.0.0/25"

	tags = {
		Name = "tuts-subnet"
	}
}

