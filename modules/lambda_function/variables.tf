variable "principal" {
	type = string
	default = "s3.amazonaws.com"
}

variable "enable_lf" {
	type = bool
	default = false
	description = "Create a lambda function or not"
}

variable "source_path" {
	default = ""
	description = "Source path of target file containing Lambda function"
}

variable "runtime_lang" {
	type = string
	default = "python3.8"
	description = "Type and version of the runtime language"
}

variable "object_for_reference" {
	type = any
	default = ""
	description = "s3_object_name for define dependency from lambda" 
}

variable "bucket_arn" {
	type = string
	default = ""
	description = "Arn of s3 bucket"
}

variable "bucket_id" {}

variable "lambda_trigger_event" {
  default     = "s3:ObjectCreated:*"
  description = "The event that triggers the lambda function"
}

variable "func_name" {
	type = string
	default = "lf-alp"
}
