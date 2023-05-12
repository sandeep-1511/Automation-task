#create security group
  resource "aws_security_group" "ssh2_group" {
  name        = "ssh2"
  description = "ssh2 security group"
  vpc_id = aws_vpc.dbvpc.id


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
output "security_group_id-2" {
  value = aws_security_group.ssh2_group.id
}
