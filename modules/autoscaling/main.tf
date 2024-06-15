resource "aws_autoscaling_group" "asg" {
  name = "Custom-AutoScalingGroup"
	min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired_capacity
	health_check_type = var.health_check_type[1]
  force_delete = var.asg_force_delete
	health_check_grace_period = var.grace_period	
	//load_balancers = [aws_elb.custom-elb.name]
	load_balancers = [var.elb]
	vpc_zone_identifier = [var.pub_sub_a, var.pub_sub_b]

	launch_template {
    id = aws_launch_template.lt.id
    version = "$Latest"   //or aws_launch_template.alt.latest_version
  }

	instance_maintenance_policy {
    min_healthy_percentage = var.min_healthy_percentage
    max_healthy_percentage = var.max_healthy_percentage
  }

  tag {
    key = "Name"
    value = "custom_ec2_instance"
  propagate_at_launch = true
  }
}

resource "aws_launch_template" "lt" {
  name = "Custom-launch-config"
  image_id = data.aws_ami.custom_ami.id
  instance_type = var.instance_type
  key_name = aws_key_pair.key.key_name
  //security_groups = [var.instance_sec_group]

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update
                sudo apt install -y apache2
                sudo systemctl start apache2
                sudo systemctlenable apache2
                echo “Hello from $(hostname -f).Created by USERDATA in Terraform. > /var/www/html/index.html
              EOF

	disable_api_stop = var.disable_api_stop  //dv
  disable_api_termination = var.disable_termination  //dv
  update_default_version = var.update_lt_version

	network_interfaces {
    associate_public_ip_address = var.associate_pub_ip
    security_groups = [var.instance_sec_group]
    subnet_id = var.pub_sub_a
    delete_on_termination = var.delete_net_interface
  }

  lifecycle {
    create_before_destroy = true
  }

	hibernation_options {
    configured = var.enable_hibernation
  }

  monitoring {
    enabled = var.enable_monitoring
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
    Name = "Custom-launch-template"
    }
  }
}

#AMI definition
data "aws_ami" "custom_ami" {
	owners = [var.ami_owner]
	most_recent = var.ami_most_recent

	filter {
		name = "name"
		values = [var.ami_source]
	}

	filter {
		name = "virtualization-type"
		values = [var.ami_virtualization_type]
	}
}

//The following 3 resources are intended for key generation(and store)
resource "tls_private_key" "key_gen" {
  algorithm = var.key_algorithm
  rsa_bits = var.rsa_bits
}

resource "aws_key_pair" "key" {
  key_name = var.key_name
  public_key = tls_private_key.key_gen.public_key_openssh
}

resource "local_file" "key_file"{
  content = tls_private_key.key_gen.private_key_pem
  filename = var.key_file
}

#define autoscaling configuration policy
resource "aws_autoscaling_policy" "scaleout_policy" {
	count = var.enable_cpu_out_alarm ? 1 : 0
  name = "CPU-scaleout-policy"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = 1
  cooldown = 60
  policy_type = "SimpleScaling"
}

#define cloud watch monitoring
resource "aws_cloudwatch_metric_alarm" "cpu_alarm_scaleup" {
	count = var.enable_cpu_out_alarm ? 1 : 0
  alarm_name = "CPU-scaleup-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 120
  statistic = "Average"
  threshold = 20

  dimensions = {
    "AutoScalingGroupName": aws_autoscaling_group.asg.name
  }

  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.scaleout_policy[0].arn]
}

#define auto descaling policy
resource "aws_autoscaling_policy" "scalein_policy" {
	count = var.enable_cpu_in_alarm ? 1 : 0
  name = "CPU-scalein-policy"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = -1
  cooldown = 60
  policy_type = "SimpleScaling"
}

#define descaling cloud watch
resource "aws_cloudwatch_metric_alarm" "cpu-alarm-scaledown" {
	count = var.enable_cpu_in_alarm ? 1 : 0
  alarm_name = "CPU-scaledown-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 120
  statistic = "Average"
  threshold = 10

  dimensions = {
    "AutoScalingGroupName": aws_autoscaling_group.asg.name
  }

  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.scalein_policy[0].arn]
}
