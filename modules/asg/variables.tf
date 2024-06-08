//Default type of variables is <string>

variable "vpc_id" {
	type = any
}

variable "associate_pub_ip" {
	type = bool
	default = true
	description = "Associate public id_address to instance or not"
}

variable "pg_name" {
	default = "test_pg"
	description = "Name for placement_group of instances"
}

variable "pg_strategy" {
	type = list(string)
	default = ["cluster", "partition", "spread"]
	description = "Values of placement_group strategies"
}

variable "lt_name" {
	default = "Custom_launch_template"
	description = "Name of the launch_template"
}

variable "instance_type" {
	default = "t3.micro"
	description = "instance_type of AWS EC2"
}

variable "key_algorithm" {
  description = "Key_algorithm(rsa, ecdsa or ed25519)"
  default     = "RSA"
}

variable "rsa_bits" {
  description = "Length of key with rsa_algorithm(2048,4096)"
  default     = 2048
}

variable "key_name" {
	default = "priv-key.pem"
	description = "Name of instance key"
}

variable "key_file" {
	default = "key.pem"
	description = "File for storing private key"
}

variable "sec_group_id" {
	type = any
	description = "Security group id"
}

variable "disable_api_stop" {
	type = bool
	default = false
	description = "Enable <Instance Stop Protection>"
}

variable "disable_termination" {
	type= bool
	default = false
	description = "Enable <Instance Termination Protection"
}

variable "user_data" {
	description = "Path of user_data script"
}

variable "update_lt_version" {
	type = bool
	default = false
	description = "Update default version of lt each update or not"
}

variable "pub_sub_a_id" {
	type = any
	description = "Id of first Public Subnet"
}

variable "pub_sub_b_id" {
  type = any
  description = "Id of second Public Subnet"
}

variable "propagate_asg_tag" {
	type = bool
	default = true
	description = "Propagate as_group tag to instances or not"
}


