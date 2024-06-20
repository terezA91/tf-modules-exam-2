resource "aws_elb" "alb" {
  name            = var.elb_name
  subnets         = [var.elb_pub_sub_a, var.elb_pub_sub_b]
  security_groups = [aws_security_group.alb_sg.id]

  listener {
    instance_port     = var.listener_port
    instance_protocol = var.listener_protocol
    lb_port           = var.listener_port
    lb_protocol       = var.listener_protocol
  }

  health_check {
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.check_timeout
    target              = var.check_target
    interval            = var.check_interval
  }

  cross_zone_load_balancing   = var.cross_zone
  connection_draining         = var.connection_draining
  connection_draining_timeout = var.draining_timeout

  tags = {
    Name = var.elb_name_tag
  }
}

resource "aws_security_group" "alb_sg" {
  name        = var.elb_sg_name
  description = var.elb_sg_desc
  vpc_id      = var.vpc

  ingress {
    from_port   = var.elb_sg_ingress_from
    to_port     = var.elb_sg_ingress_to
    protocol    = var.elb_sg_ingress_protocol
    cidr_blocks = [var.elb_sg_ingress_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.elb_sg_name_tag
  }
}

resource "aws_security_group" "instance_sg" {
  name        = var.instance_sg_name
  description = var.instance_sg_desc
  vpc_id      = var.vpc

  ingress {
    from_port       = var.instance_sg_ingress_from
    to_port         = var.instance_sg_ingress_to
    protocol        = var.instance_sg_ingress_protocol
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.instance_sg_name_tag
  }
}
