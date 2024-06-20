variable "elb_name" {
  default = "Custom-alb"
}

variable "pub_sub_a" {
  type        = any
  description = "Id of first Public Subnet"
}

variable "pub_sub_b" {
  type        = any
  description = "Id of second Public Subnet"
}

variable "listener_port" {
  type    = number
  default = 80
}

variable "listener_protocol" {
  default = "http"
}

variable "healthy_threshold" {
  type    = number
  default = 2
}

variable "unhealthy_threshold" {
  type    = number
  default = 2
}

variable "check_timeout" {
  type    = number
  default = 3
}

variable "check_target" {
  default = "HTTP:80/"
}

variable "check_interval" {
  type    = number
  default = 30
}

variable "cross_zone" {
  type    = bool
  default = true
}

variable "connection_draining" {
  type    = bool
  default = true
}

variable "draining_timeout" {
  type    = number
  default = 400
}

variable "elb_name_tag" {
  default = "Custom-alb"
}

variable "elb_sg_name" {
  default = "ELB-SecurityGroup"
}

variable "elb_sg_desc" {
  default = "Security group for ELB"
}

variable "vpc" {
  type = any
}

variable "elb_sg_ingress_from" {
  type    = number
  default = 80
}

variable "elb_sg_ingress_to" {
  type    = number
  default = 80
}

variable "elb_sg_ingress_protocol" {
  default = "tcp"
}

variable "elb_sg_ingress_cidr" {
  default = "0.0.0.0/0"
}

variable "elb_sg_name_tag" {
  default = "Custom-ELB-SecurityGroup"
}

variable "instance_sg_name" {
  default = "Instance-SecurityGroup"
}

variable "instance_sg_desc" {
  default = "Security group for Instances"
}

variable "instance_sg_ingress_from" {
  type    = number
  default = 22
}

variable "instance_sg_ingress_to" {
  type    = number
  default = 80
}

variable "instance_sg_ingress_protocol" {
  default = "tcp"
}

variable "instance_sg_name_tag" {
  default = "Custom-Instance-SecurityGroup"
}

