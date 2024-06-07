resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "Custom VPC"
    Tag = "VPC from tf"
  }
}
