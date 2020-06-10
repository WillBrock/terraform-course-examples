variable "region" {
	type = string
}

variable "ami" {
	type = string
}

variable "instance_type" {
	type    = string
	default = "t2.micro"
}
