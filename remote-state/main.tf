terraform {
	required_providers {
		aws = {
			source  = "hashicorp/aws"
			version = "~> 3.74"
		}
	}

	backend "s3" {
		bucket = "tuts-state"
		key    = "foo/terraform.tfstate"
		region = "us-west-2"
	}
}

provider "aws" {
	region = "us-west-2"
}

resource "aws_instance" "web" {
	ami           = "ami-003634241a8fcdec0"
	instance_type = "t2.micro"

	tags = {
		Name = "Tuts Test"
	}
}
