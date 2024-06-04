variable "enable_s3" {
	type = bool
	default = true
}

variable "enable_lf" {
	type = bool
	default = false
}

variable "bucket_name" {
	type = string
	default = "some-bucket"
}
