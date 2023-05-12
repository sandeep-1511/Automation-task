#instance creation
resource "aws_instance" "lmsfront" {
  ami                         =  "ami-0d09654d0a20d3ae2"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet1.id
  vpc_security_group_ids      = [aws_security_group.ssh1.id]
  availability_zone           = "ap-south-1"
  associate_public_ip_address = true
  key_name                    = "TF-key"
  tags = {
    Name = "frontend-webapp"
  }
}

  
