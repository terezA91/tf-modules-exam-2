/*
resource "aws_eip" "eip" {
  vpc = true

  tags = {
    Name = var.eip_tag
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.pub-sub-a.id
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = var.nat_gw_tag
  }
}
*/
