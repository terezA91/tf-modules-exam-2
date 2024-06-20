//Default variable type is <string>

variable "enable_ec2" {
  type    = bool
  default = false
}

variable "key_algorithm" {
  default     = "RSA"
  description = "Key_algorithm(rsa, ecdsa or ed25519)"
}

variable "rsa_bits" {
  default     = 2048
  description = "Length of key with rsa_algorithm"
}

variable "key_name" {
  default = "priv-key"
}

variable "key_file" {
  default = "key-file.pem"
}

variable "ami_most_recent" {
  type    = bool
  default = true
}

variable "filter_one_name" {
  default = "name"
}

variable "filter_one_value" {
  type    = any
  default = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
}

variable "filter_two_name" {
  default = "virtualization_type"
}

variable "filter_two_value" {
  type    = any
  default = "hvm"
}

variable "owner_account_id" {
  default = "637423489195"
}

variable "instance_type" {
  default     = "t3.micro"
  description = "Type of EC2 instance(Mix of the CPU,RAM,Disk,Network components)"
}

variable "in_public_subnet" {
  type        = bool
  default     = true
  description = "Create instance in public subnet or not"
}

variable "ec2_pub_sub_a" {
  description = "Id of the public subnet(in <a> zone)"
}

variable "ec2_pub_sub_b" {
  description = "Id of the public subnet(in <b> zone)"
}

variable "ec2_priv_sub_a" {
  description = "Id of the private subnet(in <a> zone)"
}

variable "ec2_priv_sub_b" {
  description = "Id of the private subnet(in <b> zone)"
}

variable "sec_group_id" {
  type = any
}

variable "user_data" {}

variable "instance_tag" {
  default = "Custom EC2"
}
