#nate gateway creation
resource "aws_eip" "nat-1" {}

resource "aws_nat_gateway" "nat1" {
  allocation_id = aws_eip.nat-1.id
  subnet_id     = aws_subnet.subnet1.id
  tags = {
    Name = "nat-1"
 }  
}

resource "aws_eip" "nat-2" {}

resource "aws_nat_gateway" "nat2" {
  allocation_id = aws_eip.nat-2.id
  subnet_id     = aws_subnet.subnet2.id
  tags = {
    Name = "nat-2"
 }  
}






