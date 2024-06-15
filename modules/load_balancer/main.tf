#AWS ELB config
resource "aws_elb" "alb" {
  name = "Custom-alb"
  subnets = [var.pub_sub_a, var.pub_sub_b]
  security_groups = [aws_security_group.alb_sg.id]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/"
    interval = 30
  }

  cross_zone_load_balancing = true
  connection_draining = true
  connection_draining_timeout = 400

  tags = {
    Name = "Custom-alb"
  }
}

#security group for AWS ELB
resource "aws_security_group" "alb_sg" {
	name = "ELB-SecurityGroup"
  description = "Security group for ELB"
  vpc_id = var.vpc

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

	egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Custom-ELB-SecurityGroup"
  }
}

#security group for instances
resource "aws_security_group" "instance_sg" {
	name = "Instance-SecurityGroup"
  description = "Security group for Instances"
  vpc_id = var.vpc

  ingress {
    from_port = 22
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

	egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Custom-Instance-SecurityGroup"
  }
}
