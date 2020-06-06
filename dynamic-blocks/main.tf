provider "aws" {
	version = "~> 2.65"
	region  = "us-west-2"
}

locals {
	ingress_rules = [{
		port        = 443
		description = "Port 443"
	},
	{
		port        = 80
		description = "Port 80"
	}]
}

resource "aws_security_group" "main" {
	name   = "foo"
	vpc_id = data.aws_vpc.main.id

	dynamic "ingress" {
		for_each = local.ingress_rules

		content {
			description = ingress.value.description
			from_port   = ingress.value.port
			to_port     = ingress.value.port
			protocol    = "tcp"
			cidr_blocks = ["0.0.0.0/0"]
		}
	}
	/*
	ingress {
		description = "Foo bar"
		from_port   = 443
		to_port     = 443
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	*/

	tags = {
		Name = "tuts security group"
	}
}
