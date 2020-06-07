provider "aws" {
	version = "~> 2.65"
	region  = "us-west-2"
}

resource "aws_vpc" "main" {
	cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "web" {
	vpc_id     = aws_vpc.main.id
	cidr_block = "10.0.1.0/16"
}
