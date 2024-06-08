#Key-gen
resource "tls_private_key" "key_gen" {
  algorithm = var.key_algorithm
  rsa_bits = var.rsa_bits
}

resource "aws_key_pair" "key" {
  key_name = var.key_name
  public_key = tls_private_key.key_gen.public_key_openssh
}

resource "local_file" "key-file" {
  content = tls_private_key.key_gen.private_key_pem
  filename = var.key_file
}

data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name]
  }

  filter {
    name   = "virtualization-type"
    values = [var.ami_virtualization_type]
  }

  owners = [var.owner_account_id]
}

resource "aws_instance" "pub-ec2" {
  ami           = data.aws_ami.ami.id
  instance_type = var.instance_type
  associate_public_ip_address = var.in_public_subnet
  #subnet_id = var.pub_sub_a_id
  #vpc_security_group_ids = [var.sec_group_id]
  key_name = aws_key_pair.key.key_name
  user_data = "${path.module}/./user_data/${var.user_data}"

  tags = {
    Name = "Custom EC2"
  }
}
