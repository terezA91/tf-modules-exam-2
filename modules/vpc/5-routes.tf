resource "aws_route_table" "public" {
	vpc_id = aws_vpc.vpc.id

	route {
		cidr_block = var.default_gateway
		gateway_id = aws_internet_gateway.igw.id
	}

	tags = {
		Name = "Route table for public"
	}
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.default_gateway
    gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "Route table for private"
  }
}


resource "aws_route_table_association" "public-a" {
	subnet_id = aws_subnet.pub-sub-a.id
	route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-b" {
  subnet_id = aws_subnet.pub-sub-b.id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "private-a" {
	subnet_id = aws_subnet.priv-sub-a.id
	route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-b" {
  subnet_id = aws_subnet.priv-sub-b.id
  route_table_id = aws_route_table.private.id
}

