variable "enable_alb" {
	type = bool
	default = false  //dv -?
	description = "Initialize <load_balancer> module"
}

variable "ec2_sec_group_id" { type = any }

variable "alb_sec_group_id" { type = any }

variable "vpc_id" {}

variable "ami_most_recent" {
	type = bool
	default = true
}

variable "ami_name" {
  type = any
  default = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
}

variable "ami_virtualization_type" {
  default = "hvm"
}

variable "key_algorithm" {
  type        = string
  description = "Key_algorithm(rsa, ecdsa or ed25519)"
  default     = "RSA"
}

variable "rsa_bits" {
  description = "Length of key with rsa_algorithm(2048,4096)"
  default     = 2048
}

variable "key_name" {
  default = "priv-key"
  description = "Name of instance key"
}

variable "key_file" {
  default = "key.pem"
  description = "File for storing private key"
}

variable "pub_sub_a_id" {
  type = any
  description = "Id of first Public Subnet"
}

variable "pub_sub_b_id" {
  type = any
  description = "Id of second Public Subnet"
}

