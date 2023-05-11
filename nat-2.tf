#nate gateway creation
resource "aws_eip" "nat-01" {}

resource "aws_nat_gateway" "nat01" {
  allocation_id = aws_eip.nat-01.id
  subnet_id     = aws_subnet.subnet01.id
  tags = {
    Name = "nat-01"
 }  
}

resource "aws_eip" "nat-02" {}

resource "aws_nat_gateway" "nat02" {
  allocation_id = aws_eip.nat-02.id
  subnet_id     = aws_subnet.subnet02.id
  tags = {
    Name = "nat-02"
 }  
}

