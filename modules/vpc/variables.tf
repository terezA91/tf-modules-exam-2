#Vpc variables

variable "enable_vpc" {
  type    = bool
  default = false
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "Cidr_block value of Vpc"
}

variable "vpc_tag" {
  default = "Custom VPC"
}

variable "vpc_additional_tag" {
  default = "VPC from tf"
}

variable "internet_gw_tag" {
  default = "Custom Internet Gateway"
}

variable "map_public_ip" {
  default = true
}

variable "pub_sub_a_tag" {
  default = "Public Subnet - 1"
}

variable "pub_sub_b_tag" {
  default = "Public Subnet - 2"
}

variable "priv_sub_a_tag" {
  default = "Private Subnet - 1"
}

variable "priv_sub_b_tag" {
  default = "Private Subnet - 2"
}

variable "pub_sub_cidr" {
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
  description = "Cidr_block values of the public subnets"
}

variable "priv_sub_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.3.0/24"]
  description = "Cidr_block values of the private subnets"
}

variable "az" {
  type        = list(string)
  default     = ["eu-north-1a", "eu-north-1b"]
  description = "Availability Zones in Region"
}

variable "eip_tag" {
  default = "My elastic_ip"
}

variable "nat_gw_tag" {
  default = "My NAT Gateway"
}

variable "route_table_pub" {
  default = "Route table for public"
}

variable "route_table_priv" {
  default = "Route table for private"
}

variable "sg_name" {
  default = "Custom sg"
}

variable "sg_desc" {
  default = "sg-for-public-instance"
}

variable "sg_ingress_1_desc" {
  default = "SSH"
}

variable "sg_ingress_1_port" {
  type    = number
  default = 22
}

variable "sg_ingress_protocol" {
  default = "tcp"
}

variable "default_gateway" {
  default     = "0.0.0.0/0"
  description = "Gateway for access to the internet"
}

variable "sg_ingress_2_desc" {
  default = "HTTP"
}

variable "sg_ingress_2_port" {
  type    = number
  default = 80
}

variable "sg_ingress_3_desc" {
  default = "HTTPS"
}

variable "sg_ingress_3_port" {
  type    = number
  default = 443
}

variable "sg_egress_port" {
  type    = number
  default = 0
}

variable "sg_egress_protocol" {
  default = "-1"
}

variable "sg_tag" {
  default = "My security_group"
}
