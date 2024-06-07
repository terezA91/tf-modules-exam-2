/*
resource "aws_eip" "eip" {
  vpc = true

  tags = {
    Name = "My elastic_ip"
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.pub-sub-a.id
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "My NAT Gateway"
  }
}
*/
