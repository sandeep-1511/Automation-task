#instance creation
resource "aws_instance" "darwin" {
  ami                         =  "ami-050a217bf9d70aaa6"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet01.id
  vpc_security_group_ids      = [aws_security_group.ssh2.id]
  availability_zone           = "ap-south-1a"
  associate_public_ip_address = true
  key_name                    = "TF-key"
  tags = {
    Name = "database"
  }
}
