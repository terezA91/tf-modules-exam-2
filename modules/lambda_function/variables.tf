variable "create_lf" {
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
	description = "Arn of s3 bucket"
}
