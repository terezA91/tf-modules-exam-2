//Default variable type is <string>

variable "instance_type" {
  default     = "t3.micro"
  description = "Type of EC2 instance(Mix of the CPU,RAM,Disk,Network components)"
}

variable "pub_instance_count" {
  type    = number
  default = 1
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
  default     = ""
  description = "Id of the public subnet(in <b> zone)"
}

variable "ec2_priv_sub_a" {
  default     = ""
  description = "Id of the private subnet(in <a> zone)"
}

variable "ec2_priv_sub_b" {
  default     = ""
  description = "Id of the private subnet(in <b> zone)"
}

variable "sec_group_id" {
  type = any
}

variable "useir_data" {}

variable "priv_ec2_count" {
  type    = number
  default = 1
}

variable "user_data_2" {}

variable "instance_tag" {
  default = "Custom EC2"
}

variable "priv_instance_tag" {
  default = "Custom EC2 in private"
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
