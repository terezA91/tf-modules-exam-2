variable "enable_cloudfront" {
	type = bool
	default = false
	description = "Initialize Cloudfront module or not"
}

variable "s3_bucket_name" {
  type        = string
  description = "Bucket-name for referencing from cf"
}

variable "origin_domain_name" {
  type        = string
  description = "Origin domain-name of origin source"
}

variable "origin_id" {
  type        = string
  description = "Origin-id of origin source resource"
}

variable "cache_pid" {
  type        = string
  default     = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  description = "Cache policy id for optimized cache"
}

/*
variable "origin_bucket" {
	type = string
	description = "For use in the iam-policy resource"
}
*/

variable "s3_bucket_arn" {
  type        = string
  description = "Arn value of the s3 bucket"
}
