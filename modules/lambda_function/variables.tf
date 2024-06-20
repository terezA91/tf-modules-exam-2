variable "path" {}

variable "principal" {
  default = "s3.amazonaws.com"
}

variable "source_path" {
  description = "Source path of target file containing Lambda function"
}

variable "iam_role_name" {
  default = "role-for-lambda"
}

variable "iam_role_sid" {
  default = "IamRoleForLambda"
}

variable "iam_role_effect" {
  default = "Allow"
}

variable "iam_role_tag" {
  default = "Custom Lambda role"
}

variable "iam_role_policy_name" {
  default = "For-access-to-Cloudwatch"
}

variable "archive_type" {
  default = "zip"
}

variable "function_name" {
  default = "lf-alp"
}

variable "runtime_lang" {
  default     = "python3.8"
  description = "Type and version of the runtime language"
}

variable "lambda_permission_action" {
  default = "lambda:InvokeFunction"
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
  type    = string
  default = "lf-alp"
}

