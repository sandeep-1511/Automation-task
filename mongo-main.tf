locals {
  vpc_id           = "vpc-0278f1f57b17b6dc8"
  subnet_id        = "subnet-0136d6b0ecdfa0a99"
  ssh_user         = "ubuntu"
  key_name         = "oregon"
  private_key_path = "${path.module}/keys/oregon.pem"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_route53_zone" "stage" {
  name = "darwin.com"
 
}


resource "aws_route53_record"  "db" {
  count = 3
  zone_id = "${aws_route53_zone.stage.zone_id}"
  name = "db${count.index}.test.com" //name is db[0-2].test.com
  type = "A"
  ttl = "30"
  records = ["${element(aws_instance.mongodb.*.private_ip, count.index)}"]
}

resource "aws_security_group" "mongodb" {
  name   = "mongodb"
  vpc_id = local.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "mongodb" {
  count = 3

  ami                         = "ami-0df444216ad560e50"
  subnet_id                   = local.subnet_id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.mongodb.id]
  key_name                    = local.key_name

  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = self.public_ip
    }
  }

  provisioner "local-exec" {
    command     = <<EOT
      echo "[mongodb]" > inventory.ini
      echo "${self.public_ip}" >> inventory.ini
      ansible-playbook -i inventory.ini --private-key=${local.private_key_path} mongodb.yml
    EOT
    working_dir = path.module
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "null_resource" "dependency_0" {
  triggers = {
    dependency_instance_id = aws_instance.mongodb[2].id
  }

  depends_on = [
    aws_instance.mongodb[2]
  ]
}

resource "null_resource" "dependency_1" {
  triggers = {
    dependency_instance_id = aws_instance.mongodb[0].id
  }

  depends_on = [
    aws_instance.mongodb[0]
  ]
}

resource "null_resource" "dependency_2" {
  triggers = {
    dependency_instance_id = aws_instance.mongodb[1].id
  }

  depends_on = [
    aws_instance.mongodb[1]
  ]
}
