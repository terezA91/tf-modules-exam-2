resource "aws_subnet" "pub-sub-a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.pub_sub_cidr[0]
  availability_zone = var.az[0]
  //This allocate public_ip for public ec2
  map_public_ip_on_launch = var.map_public_ip

  tags = {
    Name = var.pub_sub_a_tag
  }
}

resource "aws_subnet" "pub-sub-b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.pub_sub_cidr[1]
  availability_zone = var.az[1]
  //This allocate public_ip for public ec2
  map_public_ip_on_launch = var.map_public_ip

  tags = {
    Name = var.pub_sub_b_tag
  }
}


resource "aws_subnet" "priv-sub-a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.priv_sub_cidr[0]
  availability_zone = var.az[0]

  tags = {
    Name = var.priv_sub_a_tag
  }
}

resource "aws_subnet" "priv-sub-b" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.priv_sub_cidr[1]
  availability_zone = var.az[1]

  tags = {
    Name = var.priv_sub_b_tag
  }
}

