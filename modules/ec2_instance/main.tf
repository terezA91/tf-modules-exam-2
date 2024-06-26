locals {
  pub_subnets = [
    var.ec2_pub_sub_a,
    var.ec2_pub_sub_b
  ]

  priv_subnets = [
    var.ec2_priv_sub_a,
    var.ec2_priv_sub_b
  ]
}

resource "aws_instance" "pub-ec2" {
  ami                         = data.aws_ami.ami.id
  instance_type               = var.instance_type
  count                       = var.pub_instance_count
  associate_public_ip_address = var.in_public_subnet
  subnet_id                   = local.pub_subnets[count.index]
  vpc_security_group_ids      = [var.sec_group_id]
  key_name                    = aws_key_pair.key.key_name
  user_data                   = filebase64(var.user_data)

  tags = {
    Name = var.instance_tag
  }
}

resource "aws_instance" "priv-ec2" {
  ami                    = data.aws_ami.ami.id
  instance_type          = var.instance_type
  count                  = var.priv_ec2_count
  subnet_id              = local.priv_subnets[count.index]
  vpc_security_group_ids = [var.sec_group_id]
  key_name               = aws_key_pair.key.key_name
  user_data              = filebase64(var.user_data_2)

  tags = {
    Name = var.priv_instance_tag
  }
}

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
