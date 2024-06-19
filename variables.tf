//Provider variables
variable "config_path" {
  default     = "~/.aws/config"
  description = "Path of AWS Region configuration"
}

variable "credential_path" {
  default     = "~/.aws/credentials"
  description = "Path of AWS user credentials"
}

//Enable specific service-modules
variable "enable_alb" {
  type    = bool
  default = false
}

variable "enable_cloudfront" {
  type    = bool
  default = false
}

variable "enable_autoscaling" {
  type    = bool
  default = false
}

variable "enable_s3" {
  type    = bool
  default = false
}

variable "enable_lf" {
  type    = bool
  default = false
}

variable "enable_vpc" {
  type    = bool
  default = false
}

//>>>>> s3 module variables
variable "directory_bucket" {
  type        = bool
  default     = false //Creating <General purpose bucket>
  description = "Create bucket of type <General purpose> or <directory>"
}

variable "bucket_name" {
  default     = "bucket-alp"
  description = "Name of the s3 bucket"
}

variable "bucket_prefix" {
  default     = "alp"
  description = "Creates a unique bucket name beginning with the specified prefix"
}

variable "destroy_bucket" {
  type        = bool
  default     = true
  description = "Delete an bucket regardless of the presence of the object"
}

variable "bucket_tag_name" {
  default     = "Custom bucket"
  description = "Value of <Name> as bucket tag key"
}

variable "s3_object_path" {
  default     = ""
  description = "Source path of s3 bucket object"
}

variable "object_name" {
  default     = "s3-object-name"
  description = "User-defined object name of the bucket"
}

variable "as_website" {
  type        = bool
  default     = true
  description = "Create a bucket as a website(default) or as a storage"
}

variable "content_type" {
  default     = ""
  description = "Definition of bucket content_type"
}

variable "sse_type" {
  default     = "AES256"
  description = "Type of Server-side-encryption in s3"
}

variable "s3_block_public_acls" {
  type    = bool
  default = false
}

variable "s3_block_public_policy" {
  type    = bool
  default = false
}

variable "ignore_public_acls" {
  type    = bool
  default = false
}

variable "s3_restrict_public_buckets" {
  type    = bool
  default = false
}

//Other possible values are <Enabled>, <Suspended>
variable "enable_versioning" {
  default     = "Disabled"
  description = "Enable bucket versioning or not"
}

variable "accelerate" {
  type        = bool
  default     = false
  description = "Enable bucket_acceleration or not"
}

variable "enable_acl" {
  type        = bool
  default     = false //disabled
  description = "Enable or disable ACL"
}

//Other possible value is <ObjectWriter>
variable "ownership_type" {
  default = "BucketOwnerPreferred"
}

variable "with_cf" {
  type        = bool
  default     = false
  description = "Integrate bucket with cloudfront or not"
}

variable "policy_for_cf" {
  type        = any
  default     = ""
  description = "s3 bucket policy for cloudfront"
}

variable "cf_name" {
  type        = any
  default     = ""
  description = "Name of the <aws_cloudfront_distribution> resource"
}

variable "trigger_lambda" {
  type        = bool
  default     = false
  description = "Trigger Lambda function or not"
}

variable "lf_arn" {
  type        = any
  default     = ""
  description = "Arn of lambda function"
}

variable "lambda_trigger_event" {
  default     = "s3:ObjectCreated:*"
  description = "The event that triggers the lambda function"
}

//The actual value will be set when creating the module for s3
variable "lf_permission" {
  type        = any
  default     = ""
  description = "For referencing <aws_lambda_permission> resource"
}

variable "az_id" {
  default     = "eun1-az1"
  description = "Availability zone id"
}

variable "region" {
  default     = "eu-north-1"
  description = "Default AWS Region"
}

//>>>>>  lambda-function variables
variable "path" {
	default = ""
}

variable "source_path" {
	default = ""
	description = "Source path of target file containing Lambda function"
}

variable "object_for_reference" {
  type = any
  default = ""
  description = "s3_object_name for define dependency from lambda"
}
