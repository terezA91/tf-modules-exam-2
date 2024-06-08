//Default type of variables is <string>

variable "enable_autoscaling_module" {
	type = bool
	default = false
}

variable "min_size" {
	type = number
	default = 1
	description = "Minimum size of Autoscaling group"
}

variable "max_size" {
  type = number
  default = 1
  description = "Maximum size of Autoscaling group"
}

variable "desired_capacity" {
	type = number
	default = 1
	description = "Desired capacity of Autoscaling group"
}

variable "health_check_type" {
	type = list(string)
	default = ["EC2", "ELB"]
}

variable "asg_force_delete" {
	type = bool
	default = true
}

variable "pub_sub_a_id" {
  type = any
  description = "Id of first Public Subnet"
}

variable "pub_sub_b_id" {
  type = any
  description = "Id of second Public Subnet"
}

variable "min_healthy_percentage" {
	type = number
	default = 80
}

variable "max_healthy_percentage" {
  type = number
  default = 130
}

variable "propagate_asg_tag" {
  type = bool
  default = true
  description = "Propagate as_group tag to instances or not"
}

variable "lt_name" {
  default = "Custom_launch_template"
  description = "Name of the launch_template"
}

variable "instance_type" {
  default = "t3.micro"
  description = "instance_type of AWS EC2"
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

variable "update_lt_version" {
  type = bool
  default = false
  description = "Update default version of lt each update or not"
}

variable "associate_pub_ip" {
  type = bool
  default = true
  description = "Associate public id_address to instance or not"
}

variable "sec_group_id" {
  type = any
  description = "Security group id"
}

variable "delete_net_interface" {
  type = bool
  default = true
  description = "Delete network interface on instance termination or not"
}

variable "enable_hibernation" {
	type = bool
	default = false
	description = "Enable hibernation of instances or not"
}

variable "enable_monitoring" {
  type = bool
  default = false
  description = "Enable monitoring for instances or not"
}

variable "user_data" {
  description = "Path of user_data script"
}

variable "ami_most_recent" {
	type = bool
	default = true
}

variable "ami_name" {
	type = any
	default = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
}

variable "ami_virtualization_type" {
	defalt = "hvm"
}

/*
variable "vpc_id" {
	type = any
}
*/

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

