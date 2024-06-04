variable "principal" {
	type = string
	default = "s3.amazonaws.com"
}

variable "enable_lf" {
	type = bool
	default = true
	description = "Create a lambda function or not"
}

variable "source_dir" {
	type = string
	default = "../../python"
	description = "Source directory of target file containing Lambda function"
}

variable "runtime_lang" {
	type = string
	default = "python3.8"
	description = "Type and version of the runtime language"
}

variable "bucket_arn" {
	type = string
	default = ""
	description = "Arn of s3 bucket"
}

variable "func_name" {
	type = string
	default = "lf-alp"
}
