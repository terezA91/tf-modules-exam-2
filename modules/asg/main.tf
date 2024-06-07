resource "aws_autoscaling_group" "asg" {
	name = "My Autoscaling Group"
	min_size = 2
	max_size = 5
	desired_capacity = 3
	//health_check_type = "EC2"
	//force_delete = false
	target_group_arns = [aws_lb_target_group.target_group.arn]
	vpc_zone_identifier = [var.pub_sub_a_id, var.pub_sub_b_id]
	
	launch_template {
		id = aws_launch_template.alt.id
		version = "$Latest"   //or aws_launch_template.alt.latest_version
	}
/*
	instance_maintenance_policy {
		min_healthy_percentage = 90
		max_healthy_percentage = 110
	}
*/
	tag {
		key = "Name"
		value = "My first AS_Group"
		propagate_at_launch = var.propagate_asg_tag
	}
}

resource "aws_launch_template" "alt" {
	name = var.lt_name
	description = "Custom launch template"
	image_id = data.aws_ami.ubuntu.id
	instance_type = var.instance_type
	vpc_security_group_ids = [var.sec_group_id]
	key_name = aws_key_pair.key.key_name
/*
	disable_api_stop = var.disable_api_stop  //dv
	disable_api_termination = var.disable_termination  //dv
	update_default_version = var.update_lt_version
	
	hibernation_options {
		configured = false
	}

	monitoring {
		enabled = false
	}
*/

	tag_specifications {
    resource_type = "instance"

    tags = {
    Name = "Some-name"
    }
  }

	user_data = filebase64("${path.module}/${var.user_data}")
}

resource "aws_lb" "alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sec_group_id]
  subnets            = [var.pub_sub_a_id, var.pub_sub_b_id]
}

resource "aws_lb_target_group" "target_group" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path    = "/"
    matcher = 200
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

data "aws_ami" "ubuntu" {
	owners = ["099720109477"] 
	most_recent = true

	filter {
		name = "name"
		values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
	}

	filter {
		name = "virtualization-type"
		values = ["hvm"]
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

