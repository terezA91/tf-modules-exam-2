resource "aws_security_group" "for_ec2" {
  name = "ec2_sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group" "for_alb" {
  name = "alb_sg"
  vpc_id = var.vpc_id
}

//Security_group_rules for ec2 instance
resource "aws_security_group_rule" "ec2_ingress_1" {
  descrition = "Allow incoming traffic in ec2"
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  security_group_id = aws_security_group.for_ec2.id
  source_security_group_id = aws_security_group.for_alb.id
}

resource "aws_security_group_rule" "ec2_ingress_2" {
  description = "For health checks"
  type = "ingress"
  from_port = 8081
  to_port = 8081
  protocol = "tcp"
  security_group_id = aws_security_group.for_ec2.id
  source_security_group_id = aws_security_group.for_alb.id
}

resource "aws_security_group_rule" "ec2_egress" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.for_ec2.id
  cidr_blocks = ["0.0.0.0/0"]
}

//Security_group_rules for load balancer
resource "aws_security_group_rule" "alb_ingress_1" {
  description = "For incoming non-secure HTTP requests"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  security_group_id = aws_security_group.for_alb.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_ingress_2" {
  description = "For incomig secure HTTPS requests"
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  security_group_id = aws_security_group.for_alb.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_egress_1" {
  description = "For outgoing traffic to ec2"
  type = "egress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  security_group_id = aws_security_group.for_alb.id
  source_security_group_id = aws_security_group.for_ec2.id
}

resource "aws_security_group_rule" "alb_egress_2" {
  description = "For alb health_checks result"
  type = "egress"
  from_port = 8081
  to_port = 8081
  protocol = "tcp"
  security_group_id = aws_security_group.for_alb.id
  source_security_group_id = aws_security_group.for_ec2.id
}


resource "aws_security_group" "tf-sg" {
	name = "Custom sg"
	description = "sg-for-public-instance"
	vpc_id = aws_vpc.vpc.id

	ingress {
		description = "SSH"
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

	ingress {
    description = "HTTPS"
    from_port = 443
    to_port = 443
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
		Name = "My security_group"
	}
}

