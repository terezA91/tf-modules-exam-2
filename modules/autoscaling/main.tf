resource "aws_autoscaling_group" "asg" {
	name = "My Autoscaling Group"
	min_size = var.min_size
	max_size = var.max_size
	desired_capacity = var.desired_capacity
	health_check_type = var.health_check_type[0]
	force_delete = var.asg_force_delete
	vpc_zone_identifier = [var.pub_sub_a_id, var.pub_sub_b_id]
	
	launch_template {
		id = aws_launch_template.alt.id
		version = "$Latest"   //or aws_launch_template.alt.latest_version
	}

	instance_maintenance_policy {
		min_healthy_percentage = var.min_healthy_percentage
		max_healthy_percentage = var.max_healthy_percentage
	}

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
	//Conflict with <security_groups> attribute of <network_interfaces>
	//vpc_security_group_ids = [var.sec_group_id]
	key_name = aws_key_pair.key.key_name

	disable_api_stop = var.disable_api_stop  //dv
	disable_api_termination = var.disable_termination  //dv
	update_default_version = var.update_lt_version
	
	network_interfaces {
		associate_public_ip_address = var.associate_pub_ip
		security_groups = [var.sec_group_id]
		subnet_id = var.pub_sub_a_id
		delete_on_termination = var.delete_net_interface
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
    Name = "Some-name"
    }
  }

	user_data = filebase64("${path.module}/${var.user_data}")
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