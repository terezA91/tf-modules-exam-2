resource "aws_launch_template" "lt" {
  name                   = "my-launch-template"
  image_id               = data.aws_ami.ubuntu.id
  key_name               = aws_key_pair.key.key_name
  vpc_security_group_ids = [var.ec2_sec_group_id]

	user_data = filebase64("${path.module}/${var.user_data}")
}

resource "aws_lb_target_group" "alb_tg" {
  name = "my-alb-tg"
  port = 8080
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    enabled = true
    port = 8081
    interval = 30
    protocol = "HTTP"
    path = "/"
    matcher = "200"
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
}

resource "aws_autoscaling_group" "asg" {
	name = "my-asg"
	min_size = 1
	max_size = 2
	desired_capacity = 1
	health_check_type = "EC2"

	vpc_zone_identifier = [
		var.pub_sub_a_id,
		var. pub_sub_b_id
	]
	
	target_group_arns = [aws_lb_target_group.alb_tg.arn]

	mixed_instances_policy {
		launch_template {
			launch_template_specification {
				launch_template_id = aws_launch_template.lt.id
			}
			override {
				instance_type = "t3.micro"
			}
		}
	}
}

resource "aws_autoscaling_policy" "asg_policy" {
	name = "my-asg-policy"
	policy_type = "TargetTrackingScaling"
	autoscaling_group_name = aws_autoscaling_group.asg.name

	//estimated_instance_warmup = 300

	target_tracking_configuration {
		predefined_metric_specification {
			predefined_metric_type = "ASGAverageCPUUtilization"	
		}
		target_value = 35.0
	}
}

resource "aws_lb" "alb" {
	name = "my-alb"
	internal = false
	load_balancer_type = "application"
	security_groups = [var.alb_sec_group_id]
	subnets = [
		var.pub_sub_a_id,
		var.pub_sub_b_id
	]
}

resource "aws_alb_listener" "listener" {
	load_balancer_arn = aws_lb.alb.arn
	port = "80"
	protocol = "HTTP"

	default_action {
		type = "forward"
		target_group_arn = aws_lb_target_group.alb_tg.arn
	}
}



data "aws_ami" "ubuntu" {
  owners = ["099720109477"]
  most_recent = var.ami_most_recent

  filter {
    name = "name"
    values = [var.ami_name]
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
