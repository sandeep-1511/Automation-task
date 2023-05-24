#create security group
  resource "aws_security_group" "ssh1" {
  name        = "ssh1"
  description = "ssh1 security group"
  vpc_id = aws_vpc.appvpc.id

ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 ingress {
  from_port   = -1
  to_port     = -1
  protocol    = "icmp"
  cidr_blocks = ["aws_security_group.ssh1"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
output "security_group_id" {
  value = aws_security_group.ssh1.id
}


