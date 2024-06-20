resource "aws_security_group" "tf-sg" {
  name        = var.sg_name
  description = var.sg_desc
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = var.sg_ingress_1_desc
    from_port   = var.sg_ingress_1_port
    to_port     = var.sg_ingress_1_port
    protocol    = var.sg_ingress_protocol
    cidr_blocks = [var.default_gateway]
  }

  ingress {
    description = var.sg_ingress_2_desc
    from_port   = var.sg_ingress_2_port
    to_port     = var.sg_ingress_2_port
    protocol    = var.sg_ingress_protocol
    cidr_blocks = [var.default_gateway]
  }

  ingress {
    description = var.sg_ingress_3_desc
    from_port   = var.sg_ingress_3_port
    to_port     = var.sg_ingress_3_port
    protocol    = var.sg_ingress_protocol
    cidr_blocks = [var.default_gateway]
  }

  egress {
    from_port   = var.sg_egress_port
    to_port     = var.sg_egress_port
    protocol    = var.sg_egress_protocol
    cidr_blocks = [var.default_gateway]
  }

  tags = {
    Name = var.sg_tag
  }
}

