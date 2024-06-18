variable "enable_s3" {
  type        = bool
  default     = true
  description = "initialize s3 module or not"
}

variable "directory_bucket" {
  type        = bool
  default     = false //Creating <General purpose bucket>
  description = "Create bucket of type <General purpose> or <directory>"
}

variable "bucket_name" {
  description = "Name of the s3 bucket"
  default     = "bucket-alp"
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
  default     = "s3-object"
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
  description = "s3 bucket policy for cloudfront"
}

variable "cf_name" {
  type        = any
  description = "Name of the <aws_cloudfront_distribution> resource"
}

variable "trigger_lambda" {
  type        = bool
  default     = false
  description = "Trigger Lambda function or not"
}

variable "lf_arn" {
  type        = any
  description = "Arn of lambda function"
}

variable "lambda_trigger_event" {
  default     = "s3:ObjectCreated:*"
  description = "The event that triggers the lambda function"
}

//The actual value will be set when creating the module for s3
variable "lf_permission" {
  type        = any
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


variable "lf_role_policy" {
	type = any
	default = ""
}
