//Provider variables
variable "config_path" {
  default     = "~/.aws/config"
  description = "Path of AWS Region configuration"
}

variable "credential_path" {
  default     = "~/.aws/credentials"
  description = "Path of AWS user credentials"
}

//>>>>>  s3 module variables
variable "s3_object_path" {
  description = "Source path of s3 bucket object"
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

variable "lf_arn" {
  type        = any
  default     = ""
  description = "Arn of lambda function"
}

variable "lf_permission" {
  type        = any
  default     = ""
  description = "For referencing <aws_lambda_permission> resource"
}

//>>>>>  Lambda-Function variables
variable "path" {
  default = ""
}

variable "source_path" {
  default     = ""
  description = "Source path of target file containing Lambda function"
}

variable "source_arn" {
  default     = ""
  description = "Arn of Lambda origin"
}

variable "origin_id" {
  type    = any
  default = ""
}

//>>>>>  CloudFront distribution variables
variable "origin_name" {
  default     = ""
  description = "Bucket-name for referencing from cf"
}

variable "origin_domain_name" {
  default     = ""
  description = "Origin domain-name of origin source"
}

variable "cf_origin_id" {
  default     = ""
  description = "Origin-id of origin source resource"
}

variable "origin_arn" {
  default     = ""
  description = "Arn value of the s3 bucket"
}

//>>>>>  Autoscaling Group variables
variable "lt_userdata" {
  default     = ""
  description = "Path of user_data for launch template"
}

variable "instance_sec_group" {
  type    = any
  default = null
}

variable "elb" {
  type    = any
  default = null
}

variable "pub_sub_a" {
  type        = any
  default     = null
  description = "Id of first Public Subnet"
}

variable "pub_sub_b" {
  type        = any
  default     = null
  description = "Id of second Public Subnet"
}

//>>>>>  Load Balancer module variables
variable "elb_pub_sub_a" {
  type        = any
  default     = null
  description = "Id of first Public Subnet"
}

variable "elb_pub_sub_b" {
  type        = any
  default     = null
  description = "Id of second Public Subnet"
}

variable "vpc" {
  type    = any
  default = null
}

//>>>>>  EC2_instance module variables
variable "ec2_pub_sub_a" {
  default = ""
}

variable "ec2_pub_sub_b" {
  default = ""
}

variable "ec2_priv_sub_a" {
  default = ""
}

variable "ec2_priv_sub_b" {
  default = ""
}

variable "sec_group_id" {
  default = ""
}

variable "user_data" {
  default = ""
}

variable "user_data_2" {
  default = ""
}
