# vpc creation
resource "aws_vpc" "appvpc" {
  cidr_block       = "10.0.0.0/16"
  tags = {
    Name = "digitallink"
  }
}
#subnet creation 1

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.appvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "pubsub1"
  }
}
#subnet creation 2
resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.appvpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1b"
  tags = {
   Name = "pubsub2"
   }
}
#subnet creation 3

resource "aws_subnet" "subnet3" {
  vpc_id     = aws_vpc.appvpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "pvtsub1"
  }
}

#subnet creation 4

resource "aws_subnet" "subnet4" {
  vpc_id     = aws_vpc.appvpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "pvtsub2"
  }
}

#subnet creation 5

resource "aws_subnet" "subnet5" {
  vpc_id     = aws_vpc.appvpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "pvtsub3"
  }
}

#subnet creation 6

resource "aws_subnet" "subnet6" {
  vpc_id     = aws_vpc.appvpc.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "pvtsub4"
  }
}

#Internetgateway
resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.appvpc.id
  tags = {
   Name = "igway"
    }
}
#create route table

resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.appvpc.id
   tags = {
    Name = "public_rt"
     }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG.id
  }
}


#create route table1

resource "aws_route_table" "route_table_private1" {
  vpc_id = aws_vpc.appvpc.id
   tags = {
    Name = "pvt1_rt"
     }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat1.id
  }
}

#create route table2

resource "aws_route_table" "route_table_private2" {
  vpc_id = aws_vpc.appvpc.id
   tags = {
    Name = "pvt2_rt"
     }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat2.id
  }
}

#create route table3

resource "aws_route_table" "route_table_private3" {
  vpc_id = aws_vpc.appvpc.id
   tags = {
    Name = "pvt3_rt"
     }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat1.id
  }
}

#create route table4

resource "aws_route_table" "route_table_private4" {
  vpc_id = aws_vpc.appvpc.id
   tags = {
    Name = "pvt4_rt"
     }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat2.id
  }
}

#route table Association01

resource "aws_route_table_association" "route_table_public" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table_public.id
}
#route table association02
resource "aws_route_table_association" "route_table_public" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.route_table_public.id
}
#route table Association03

resource "aws_route_table_association" "route_table_private1" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.route_table_private1.id
}
#route table Association04

resource "aws_route_table_association" "route_table_private2" {
  subnet_id      = aws_subnet.subnet4.id
  route_table_id = aws_route_table.route_table_private2.id
}
#route table Association5

resource "aws_route_table_association" "route_table_private3" {
  subnet_id      = aws_subnet.subnet5.id
  route_table_id = aws_route_table.route_table_private3.id
}
#route table Association6

resource "aws_route_table_association" "route_table_private4" {
  subnet_id      = aws_subnet.subnet6.id
  route_table_id = aws_route_table.route_table_private4.id
}

    



