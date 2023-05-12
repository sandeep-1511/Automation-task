# vpc creation
resource "aws_vpc" "dbvpc" {
  cidr_block       = "192.168.0.0/16"
  tags = {
    Name = "dbvpc"
  }
}
#subnet creation 1

resource "aws_subnet" "subnet01" {
  vpc_id     = aws_vpc.dbvpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-1d"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "pubsub01"
  }
}
#subnet creation 2
resource "aws_subnet" "subnet02" {
  vpc_id     = aws_vpc.dbvpc.id
  cidr_block = "192.168.2.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = "true"
  tags = {
   Name = "pubsub02"
   }
}
#subnet creation 3

resource "aws_subnet" "subnet03" {
  vpc_id     = aws_vpc.dbvpc.id
  cidr_block = "192.168.3.0/24"
  availability_zone = "us-east-1d"
  tags = {
    Name = "pvtsub01"
  }
}

#subnet creation 4

resource "aws_subnet" "subnet04" {
  vpc_id     = aws_vpc.dbvpc.id
  cidr_block = "192.168.4.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "pvtsub02"
  }
}

#subnet creation 5

resource "aws_subnet" "subnet05" {
  vpc_id     = aws_vpc.dbvpc.id
  cidr_block = "192.168.5.0/24"
  availability_zone = "us-east-1d"
  tags = {
    Name = "pvtsub03"
  }
}

#subnet creation 6

resource "aws_subnet" "subnet06" {
  vpc_id     = aws_vpc.dbvpc.id
  cidr_block = "192.168.6.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "pvtsub04"
  }
}

#Internetgateway
resource "aws_internet_gateway" "IG-02" {
  vpc_id = aws_vpc.dbvpc.id
  tags = {
   Name = "igway-02"
    }
}
#create route table

resource "aws_route_table" "route_table_public01" {
  vpc_id = aws_vpc.dbvpc.id
   tags = {
    Name = "public01_rt"
     }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG-02.id
  }
}


#create route table1

resource "aws_route_table" "route_table_private01" {
  vpc_id = aws_vpc.dbvpc.id
   tags = {
    Name = "pvt01_rt"
     }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat01.id
  }
}

#create route table2

resource "aws_route_table" "route_table_private02" {
  vpc_id = aws_vpc.dbvpc.id
   tags = {
    Name = "pvt02_rt"
     }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat02.id
  }
}

#create route table3

resource "aws_route_table" "route_table_private03" {
  vpc_id = aws_vpc.dbvpc.id
   tags = {
    Name = "pvt03_rt"
     }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat01.id
  }
}

#create route table4

resource "aws_route_table" "route_table_private04" {
  vpc_id = aws_vpc.dbvpc.id
   tags = {
    Name = "pvt04_rt"
     }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat02.id
  }
}

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

#route table Association01

resource "aws_route_table_association" "route" {
  subnet_id      = aws_subnet.subnet01.id
  route_table_id = aws_route_table.route_table_public01.id
}
#route table association02
resource "aws_route_table_association" "route02" {
  subnet_id      = aws_subnet.subnet02.id
  route_table_id = aws_route_table.route_table_public01.id
}
#route table Association03

resource "aws_route_table_association" "route_table_private01" {
  subnet_id      = aws_subnet.subnet03.id
  route_table_id = aws_route_table.route_table_private01.id
}
#route table Association04

resource "aws_route_table_association" "route_table_private02" {
  subnet_id      = aws_subnet.subnet04.id
  route_table_id = aws_route_table.route_table_private02.id
}
#route table Association5

resource "aws_route_table_association" "route_table_private03" {
  subnet_id      = aws_subnet.subnet05.id
  route_table_id = aws_route_table.route_table_private03.id
}
#route table Association6

resource "aws_route_table_association" "route_table_private04" {
  subnet_id      = aws_subnet.subnet06.id
  route_table_id = aws_route_table.route_table_private04.id
}
