terraform {
	required_providers {
		aws = {
			source  = "hashicorp/aws"
			version = "~> 3.74"
		}
	}
}

provider "aws" {
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

/*
resource "aws_elastic_beanstalk_application" "tftest" {
	name        = "tf-test-name"
	description = "tf-test-desc"
}

resource "aws_elastic_beanstalk_environment" "tfenvtest" {
	name                = "tf-test-name"
	application         = "${aws_elastic_beanstalk_application.tftest.name}"
	solution_stack_name = "64bit Amazon Linux 2015.03 v2.0.3 running Go 1.4"

	setting {
		namespace = "aws:ec2:vpc"
		name      = "VPCId"
		value     = "vpc-xxxxxxxx"
	}

	setting {
		namespace = "aws:ec2:vpc"
		name      = "Subnets"
		value     = "subnet-xxxxxxxx"
	}
}
*/
