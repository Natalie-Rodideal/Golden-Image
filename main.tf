provider "aws" {
  profile = var.profile
  region  = var.region
}


resource "aws_instance" "testpacker-ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_pair
  subnet_id     = var.subnet_id
  vpc_security_group_ids = ["${aws_security_group.ec2-sg.id}"]
  tags          = var.tags

}

resource "aws_security_group" "ec2-sg" {
  name        = "${var.environment}-ec2-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}

output "public_ip" {
  value = aws_instance.testpacker-ec2.public_ip
}

output "public_dns" {
  value = aws_instance.testpacker-ec2.public_dns
}