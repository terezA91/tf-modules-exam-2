#Vpc variables

variable "ebanle_vpc" {
	type = bool
	default = false
}

variable "vpc_cidr" {
	type = string
	default = "10.0.0.0/16"
	description = "Cidr_block value of Vpc"
}

variable "pub_sub_cidr" {
	type = list(string)
	default = ["10.0.0.0/24", "10.0.1.0/24"]
	description = "Cidr_block values of the public subnets"
}

variable "priv_sub_cidr" {
  type = list(string)
  default = ["10.0.2.0/24", "10.0.3.0/24"]
  description = "Cidr_block values of the private subnets"
}

variable "az" {
	type = list(string)
	default = ["eu-north-1a", "eu-north-1b"]
	description = "Availability Zones in Region"
}

variable "default_gateway" {
	type = string
	default = "0.0.0.0/0"
	description = "Gateway for access to the internet"
}
