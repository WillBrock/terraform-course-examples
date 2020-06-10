provider "aws" {
	version = "~> 2.65"
	region  = "us-west-2"
}

resource "aws_instance" "web" {
	ami           = "ami-003634241a8fcdec0"
	instance_type = "t2.micro"

	tags = {
		Name = "Tuts Test"
	}
}

output "instance" {
	value = aws_instance.web
	description = "Web instance"
	# Wont show in the cli
	# Still visible in state data
	# Could be used in a module
	sensitive = true
}

output "public_ip" {
	value = aws_instance.web.public_ip
}
