//Default variable type is <string>
 
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

variable "ami_name" {
  default = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
  description = "Name of ec2_instance ami"
}

variable "ami_virtualization_type" {
  default = "hvm"
}

variable "owner_account_id" {
  default = "099720109477"  //Canonical(ubuntu)
}

variable "instance_type" {
  default = "t3.micro"
  description = "Type of EC2 instance(Mix of the CPU,RAM,Disk,Network components)"
}

variable "in_public_subnet" {
  type = bool
  default = true
  description = "Create instance in public subnet or not"
}

variable "pub_sub_a_id" {
  default = ""
  description = "Id of the public subnet(in <a> zone)"
}

variable "pub_sub_b_id" {
  default = ""
  description = "Id of the public subnet(in <b> zone)"
}

variable "priv_sub_a_id" {
  default = ""
  description = "Id of the private subnet(in <a> zone)"
}

variable "priv_sub_b_id" {
  default = ""
  description = "Id of the private subnet(in <b> zone)"
}

variable "sec_group_id" {
  type = any
  default = ""
}

variable "user_data" {
  description = "File_name for run containing script"
}
