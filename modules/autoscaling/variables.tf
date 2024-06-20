//Default type of variables is <string>

variable "enable_autoscaling" {
  type    = bool
  default = false
}

variable "min_size" {
  type        = number
  default     = 1
  description = "Minimum size of Autoscaling group"
}

variable "max_size" {
  type        = number
  default     = 3
  description = "Maximum size of Autoscaling group"
}

variable "desired_capacity" {
  type        = number
  default     = 2
  description = "Desired capacity of Autoscaling group"
}

variable "health_check_type" {
  type    = string
  default = "ELB"
}

variable "asg_force_delete" {
  type    = bool
  default = true
}

variable "grace_period" {
  type        = number
  default     = 100
  description = "health-check grace period"
}

variable "elb" {
  type = any
}

variable "pub_sub_a" {
  type        = any
  description = "Id of first Public Subnet"
}

variable "pub_sub_b" {
  type        = any
  description = "Id of second Public Subnet"
}

variable "min_healthy_percentage" {
  type    = number
  default = 80
}

variable "max_healthy_percentage" {
  type    = number
  default = 130
}

variable "asg_tag_key" {
  default = "Name"
}

variable "asg_tag_value" {
  default = "Custom-EC2-instance"
}

variable "propagate_asg_tag" {
  type        = bool
  default     = true
  description = "Propagate as_group tag to instances or not"
}

variable "lt_name" {
  default     = "Custom_launch_template"
  description = "Name of the launch_template"
}

variable "instance_type" {
  default     = "t3.micro"
  description = "instance_type of AWS EC2"
}

variable "lt_userdata" {
  description = "Path of user_data for launch template"
}

variable "disable_api_stop" {
  type        = bool
  default     = false
  description = "Enable <Instance Stop Protection>"
}

variable "disable_termination" {
  type        = bool
  default     = false
  description = "Enable <Instance Termination Protection"
}

variable "update_lt_version" {
  type        = bool
  default     = false
  description = "Update default version of lt each update or not"
}

variable "associate_pub_ip" {
  type        = bool
  default     = true
  description = "Associate public id_address to instance or not"
}

variable "instance_sec_group" {
  type = any
}

variable "delete_net_interface" {
  type        = bool
  default     = true
  description = "Delete network interface on instance termination or not"
}

variable "enable_hibernation" {
  type        = bool
  default     = false
  description = "Enable hibernation of instances or not"
}

variable "enable_monitoring" {
  type        = bool
  default     = false
  description = "Enable monitoring for instances or not"
}

variable "lt_name_tag" {
  default = "Custom-launch-template"
}

variable "ami_owner" {
  default     = "637423489195"
  description = "Account_id of ami owner"
}

variable "ami_most_recent" {
  type    = bool
  default = true
}

variable "ami_source" {
  type    = any
  default = "637423489195/my_ami"
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
  default     = "priv-key"
  description = "Name of instance key"
}

variable "key_file" {
  default     = "key.pem"
  description = "File for storing private key"
}

variable "enable_cpu_out_alarm" {
  type    = bool
  default = false //dv-?
}

variable "out_policy_name" {
  default = "CPU-scaleout-policy"
}

variable "out_policy_adjust_type" {
  default = "ChangeInCapacity"
}

variable "out_scale_adjust" {
  type    = number
  default = 1
}

variable "out_policy_cooldown" {
  type    = number
  default = 60
}

variable "out_policy_type" {
  default = "SimpleScaling"
}

variable "up_alarm_name" {
  default = "CPU-scaleup-alarm"
}

variable "up_comparison_op" {
  default = "GreaterThanOrEqualToThreshold"
}

variable "up_evaluation_period" {
  default = 2
}

variable "up_metric_name" {
  default = "CPUUtilization"
}

variable "alarm_namespace" {
  default = "AWS/EC2"
}

variable "alarm_period" {
  type    = number
  default = 120
}

variable "alarm_statistic" {
  default = "Average"
}

variable "up_threshold" {
  type    = number
  default = 20
}

variable "enable_cpu_in_alarm" {
  type    = bool
  default = false //dv-?
}

variable "in_policy_name" {
  default = "CPU-scalein-policy"
}

variable "in_policy_adjust_type" {
  default = "ChangeInCapacity"
}

variable "in_scale_adjust" {
  type    = number
  default = -1
}

variable "in_policy_cooldown" {
  type    = number
  default = 60
}

variable "in_policy_type" {
  default = "SimpleScaling"
}

variable "down_alarm_name" {
  default = "CPU-scaledown-alarm"
}

variable "down_comparison_op" {
  default = "LessThanOrEqualToThreshold"
}

variable "down_evaluation_period" {
  type    = number
  default = 2
}

variable "down_metric_name" {
  default = "CPUUtilization"
}

variable "down_threshold" {
  type    = number
  default = 10
}
