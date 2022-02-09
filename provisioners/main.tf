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
	key_name      = "william"

	tags = {
		Name = "Tuts test"
	}

	connection {
		type        = "ssh"
		host        = self.public_ip
		user        = "ubuntu"
		private_key = file("/home/focus/Downloads/william.pem")
		# Default timeout is 5 minutes
		timeout     = "4m"
	}

	provisioner "file" {
		content     = "Hello there"
		destination = "/home/ubuntu/tuts.txt"
	}

	provisioner "local-exec" {
		command = "echo ${self.public_ip} > instance-ip.txt"
	}

	provisioner "remote-exec" {
		inline = [
			"touch /home/ubuntu/tuts-remote-exec.txt"
		]
	}
}
