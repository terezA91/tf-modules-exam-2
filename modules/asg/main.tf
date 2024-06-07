resource "aws_autoscaling_group" "asg" {
	name = "My Autoscaling Group"
	min_size = 1
	max_size = 3
	desired_capacity = 1
	//health_check_type = "EC2"
	//force_delete = false
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
	disable_api_stop = var.disable_api_stop  //dv
	disable_api_termination = var.disable_termination  //dv
	update_default_version = var.update_lt_version
	
	hibernation_options {
		configured = false
	}

	monitoring {
		enabled = false
	}

	user_data = filebase64("${path.module}/${var.user_data}")
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

