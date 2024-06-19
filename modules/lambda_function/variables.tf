variable "path" {}

variable "principal" {
	default = "s3.amazonaws.com"
}

variable "enable_lf" {
	type = bool
	default = false
	description = "Create a lambda function or not"
}

variable "source_path" {
	description = "Source path of target file containing Lambda function"
}

variable "runtime_lang" {
	default = "python3.8"
	description = "Type and version of the runtime language"
}

variable "source_arn" {
	description = "Arn of Lambda origin"
}

variable "origin_id" {
	type = any
}

variable "lambda_trigger_event" {
  default     = "s3:ObjectCreated:*"
  description = "The event that triggers the lambda function"
}

variable "func_name" {
	type = string
	default = "lf-alp"
}

