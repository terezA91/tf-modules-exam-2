resource "aws_autoscaling_group" "asg" {
  name                      = var.asg_name
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  health_check_type         = var.health_check_type
  force_delete              = var.asg_force_delete
  health_check_grace_period = var.grace_period
  load_balancers            = [var.elb]
  vpc_zone_identifier       = [var.pub_sub_a, var.pub_sub_b]

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest" //or aws_launch_template.alt.latest_version
  }

  instance_maintenance_policy {
    min_healthy_percentage = var.min_healthy_percentage
    max_healthy_percentage = var.max_healthy_percentage
  }

  tag {
    key                 = var.asg_tag_key
    value               = var.asg_tag_value
    propagate_at_launch = var.propagate_asg_tag
  }
}

resource "aws_launch_template" "lt" {
  name          = var.lt_name
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.with_ssh ? aws_key_pair.key.key_name : null
  user_data     = filebase64(var.lt_userdata)

  disable_api_stop        = var.disable_api_stop
  disable_api_termination = var.disable_termination
  update_default_version  = var.update_lt_version

  network_interfaces {
    associate_public_ip_address = var.associate_pub_ip
    security_groups             = [var.instance_sec_group]
    subnet_id                   = var.pub_sub_a //problem
    delete_on_termination       = var.delete_net_interface
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
      Name = var.lt_name_tag
    }
  }
}

resource "aws_autoscaling_policy" "scaleout_policy" {
  count                  = var.enable_cpu_out_alarm ? 1 : 0
  name                   = var.out_policy_name
  autoscaling_group_name = aws_autoscaling_group.asg.name
  adjustment_type        = var.out_policy_adjust_type
  scaling_adjustment     = var.out_scale_adjust
  cooldown               = var.out_policy_cooldown
  policy_type            = var.out_policy_type
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm_scaleup" {
  count               = var.enable_cpu_out_alarm ? 1 : 0
  alarm_name          = var.up_alarm_name
  comparison_operator = var.up_comparison_op
  evaluation_periods  = var.up_evaluation_period
  metric_name         = var.up_metric_name
  namespace           = var.alarm_namespace
  period              = var.alarm_period
  statistic           = var.alarm_statistic
  threshold           = var.up_threshold

  dimensions = {
    "AutoScalingGroupName" : aws_autoscaling_group.asg.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scaleout_policy[0].arn]
}

resource "aws_autoscaling_policy" "scalein_policy" {
  count                  = var.enable_cpu_in_alarm ? 1 : 0
  name                   = var.in_policy_name
  autoscaling_group_name = aws_autoscaling_group.asg.name
  adjustment_type        = var.in_policy_adjust_type
  scaling_adjustment     = var.in_scale_adjust
  cooldown               = var.in_policy_cooldown
  policy_type            = var.in_policy_type
}

resource "aws_cloudwatch_metric_alarm" "cpu-alarm-scaledown" {
  count               = var.enable_cpu_in_alarm ? 1 : 0
  alarm_name          = var.down_alarm_name
  comparison_operator = var.down_comparison_op
  evaluation_periods  = var.down_evaluation_period
  metric_name         = var.down_metric_name
  namespace           = var.alarm_namespace
  period              = var.alarm_period
  statistic           = var.alarm_statistic
  threshold           = var.down_threshold

  dimensions = {
    "AutoScalingGroupName" : aws_autoscaling_group.asg.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scalein_policy[0].arn]
}

//The following 3 resources are intended for key generation(and store)
resource "tls_private_key" "key_gen" {
  algorithm = var.key_algorithm
  rsa_bits  = var.rsa_bits
}

resource "aws_key_pair" "key" {
  key_name   = var.key_name
  public_key = tls_private_key.key_gen.public_key_openssh
}

resource "local_file" "key_file" {
  content  = tls_private_key.key_gen.private_key_pem
  filename = var.key_file
}
