resource "aws_instance" "example" {
  ami           = "ami-00ec2b52028b906bf"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet-1.id
  key_name      = "TF-key"
  security_groups = [aws_security_group.demosg.id]

  user_data = <<-EOF
    #!/bin/bash
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    sudo apt-get install unzip
    unzip awscliv2.zip
    sudo ./aws/install
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo chmod +x kubectl
    sudo mv kubectl /usr/local/bin/kubectl
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    sudo mv /tmp/eksctl /usr/local/bin/eksctl
    eksctl register cluster --name eks-cluster --provider EKS_ANYWHERE --region us-east-1
    aws eks update-kubeconfig --region us-east-1 --name eks-cluster
  EOF

  tags = {
    Name = "master"
  }

  iam_instance_profile = aws_iam_instance_profile.admin_role.name
}

resource "aws_iam_instance_profile" "admin_role" {
  name = "admin-role"
  role = aws_iam_role.admin_role.name
}

resource "aws_iam_role" "admin_role" {
  name               = "admin-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "admin_policy_attachment" {
  name       = "admin-policy-attachment"
  roles      = [aws_iam_role.admin_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
