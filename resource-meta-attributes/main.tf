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

resource "aws_instance" "web" {
	count         = 2
	ami           = "ami-003634241a8fcdec0"
	instance_type = "t2.micro"

	tags = {
		Name = "Tuts Test ${count.index}"
	}
}
output "foo" {
	# lists out an list/array of instance ids
	#value = aws_instance.web[*].id
	value = [for instance in aws_instance.web : instance.public_ip]
}
#aws_instance.web[0].id
#aws_instance.web.*.id
/*
resource "aws_instance" "web" {
	for_each = {
		size1 = "t2.micro"
		size2 = "t2.large"
	}

	ami           = "ami-003634241a8fcdec0"
	instance_type = each.value

	tags = {
		Name = each.key
	}
}
#aws_instance.web["foo"].id
*/

/*
resource "aws_instance" "web" {
	provider      = aws.east
	ami           = "ami-085925f297f89fce1"
	instance_type = "t2.micro"

	tags = {
		Name = "Tuts in the east"
	}
}

resource "aws_instance" "web" {
	provider      = aws.east
	ami           = "ami-085925f297f89fce1"
	instance_type = "t2.micro"

	tags = {
		Name = "Tuts in the east"
	}

	lifecycle {
		create_before_destroy = true
		prevent_destroy       = true
		ignore_changes        = [tags]
	}
}
*/
