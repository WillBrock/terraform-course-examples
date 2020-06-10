provider "aws" {
	version = "~> 2.65"
	region  = var.region
}

locals {
	name = "${terraform.workspace}-instance"
}

resource "aws_instance" "main" {
	ami           = var.ami
	instance_type = var.instance_type

	tags = {
		Name = local.name
	}
}
