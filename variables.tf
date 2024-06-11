variable "region" {
	default = ""
}

variable "enable_alb" {
	type = bool
	default = false
}

variable "enable_cloudfront" {
	type = bool
	default = false
}

variable "enable_autoscaling" {
	type = bool
	default = false
}

variable "enable_s3" {
	type = bool
	default = false
}

variable "enable_vpc" {
	type = bool
	default = false
}

variable "bucket_name" {
	type = string
	description = "Name of the s3 bucket"
	default = "bucket-alp2"
}

variable "trigger_lambda" {
	type = bool
	default = false
}


