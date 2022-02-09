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

provider "aws" {
	alias  = "east"
	region = "us-east-1"
}

resource "aws_vpc" "main" {
	cidr_block = "10.0.0.0/16"
}

/*
data "aws_vpc" "foo" {
	provider = aws.east
	default  = true
}
*/

module "webserver" {
	source        = "./modules"
	name          = "tuts-webserver"
	vpc_id        = aws_vpc.main.id
	cidr_block    = cidrsubnet(aws_vpc.main.cidr_block, 4, 1)
	ami           = "ami-003634241a8fcdec0"
	instance_type = "t2.micro"
}

/*
module "webserver2" {
	source        = "./modules"
	name          = "tuts-webserver2"
	vpc_id        = data.aws_vpc.foo.id
	cidr_block    = "172.31.96.0/20"
	ami           = "ami-085925f297f89fce1"
	instance_type = "t2.large"

	providers = {
		aws = aws.east
	}
}
*/

# resource "aws_elb" "main" {
# 	instances = module.webserver.id
# }

output "webserver" {
	value = module.webserver.instance.public_ip
}

output "foo" {
	value = data.aws_vpc.foo
}
