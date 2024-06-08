variable "enable_autoscaling" {
	type = bool
	default = false
}

variable "enable_s3" {
	type = bool
	default = false
	description = "initialize s3 module or not"
}

variable "bucket_name" {
	type = string
	description = "Name of the s3 bucket"
	default = "bucket-alp2"
}


