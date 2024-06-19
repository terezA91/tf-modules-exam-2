variable "enable_cloudfront" {
  type        = bool
  default     = false
  description = "Initialize Cloudfront module or not"
}

variable "oac_name" {
  default     = "My-OAC"
  description = "Name of <origin access control>"
}

variable "oac_desc" {
  default = "cf OAC for access to non-public s3 origin"
}

variable "origin_type" {
  default = "s3"
}

variable "sign_behavior" {
  default = "always"
}

variable "sign_protocol" {
  default = "sigv4"
}

variable "origin_name" {
  description = "Bucket-name for referencing from cf"
}

variable "origin_domain_name" {
  description = "Origin domain-name of origin source"
}

variable "cf_origin_id" {
  description = "Origin-id of origin source resource"
}

variable "enable_cf_resource" {
  type    = bool
  default = true
}

variable "default_object" {
  default = "index.html"
}

variable "wait" {
  type    = bool
  default = true
}

variable "viewer_protocol" {
  default = "allow-all"
}

variable "restriction_type" {
  default = "none"
}

variable "default_certificate" {
  type    = bool
  default = true
}

variable "iam_policy_sid" {
  default = "PolicyForCfToS3"
}

variable "policy_effect" {
  default = "Allow"
}

variable "policy_action" {
  default = "s3:GetObject"
}

variable "principal_type" {
  default = "Service"
}

variable "principle_identity" {
  default = "cloudfront.amazonaws.com"
}

variable "cache_pid" {
  default     = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  description = "Cache policy id for optimized cache"
}

variable "origin_arn" {
  description = "Arn value of the s3 bucket"
}

/*
variable "origin_bucket" {
	description = "For use in the iam-policy resource"
}
*/

