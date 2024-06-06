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

variable "bucket_prefix" {
	type = string
	default = "alp"
	description = "Creates a unique bucket name beginning with the specified prefix"
}

variable "destroy_bucket" {
	type = bool
	description = "Delete an bucket regardless of the presence of the object"
	default = true
}

//The actual value will be set when creating the module for s3
variable "lf_permission" {
	type = any
	default = ""
	description = "For referencing <aws_lambda_permission> resource"
}

variable "directory_bucket" {
  type = bool
  default = false //Creating <General purpose bucket>
  description = "Create bucket of type <General purpose> or <directory>"
}

variable "object_source" {
  type = string
	default = "../../source_objects/index.html"
  description = "Source path of the s3 bucket object"
}

variable "object_name" {
  type = string
  default = "index.html"
  description = "User-defined object name of the bucket"
}

variable "s3_block_public_acls" {
	type = bool
	default = true
}

variable "s3_block_public_policy" {
  type = bool
  default = true
}

variable "ignore_public_acls" {
	type = bool
	default = true
}

variable "s3_restrict_public_buckets" {
  type = bool
  default = true
}

variable "enable_versioning" {
	type = list(string)
	description = "Enable bucket versioning or not"
	default = ["Disabled", "Enabled", "Suspended"]
}

variable "as_website" {
	type = bool
	description = "Create a bucket as a website(default) or as a storage"
	default = true
}

variable "accelerate" {
	type = bool
	default = false
	description = "Enable bucket_acceleration or not"
}

variable "enable_acl" {
  type = bool
  default = false  //disabled
  description = "Enable or disable ACL"
}

variable "trigger_lambda" {
	type = bool
	default = false
	description = "Trigger Lambda function or not"
}

//The actual value will be set when creating the module for s3
variable "lf_arn" {
	type = string
	default = ""
	description = "Arn of lambda function"
}

variable "cf_name" {
	type = any
	default = ""
	description = "Name of the <aws_cloudfront_distribution> resource"
}

variable "policy_for_cf" {
	type = any
	default = ""
	description = "s3 bucket policy for cloudfront"
}