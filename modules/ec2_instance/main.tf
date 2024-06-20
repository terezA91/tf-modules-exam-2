#Key-gen
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

data "aws_ami" "ami" {
  owners      = [var.owner_account_id]
  most_recent = var.ami_most_recent
  /*
  filter {
    name   = var.filter_one_name
    values = [var.filter_one_value]
  }

  filter {
    name   = var.filter_two_name
    values = [var.filter_two_value]
  }
*/
}

resource "aws_instance" "pub-ec2" {
  ami                         = data.aws_ami.ami.id
  instance_type               = var.instance_type
  associate_public_ip_address = var.in_public_subnet
  subnet_id                   = var.ec2_pub_sub_a
  vpc_security_group_ids      = [var.sec_group_id]
  key_name                    = aws_key_pair.key.key_name
  user_data                   = "${path.module}/./user_data/${var.user_data}"

  tags = {
    Name = var.instance_tag
  }
}
