resource "aws_instance" "devops_ec2" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  key_name = "devops-key"

  security_groups = [aws_security_group.web_sg.name]

  tags = {
    Name = "task-tracker-server"
  }
}

resource "aws_security_group" "web_sg" {

  name = "task-tracker-sg"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "logs" {
  bucket = "task-tracker-devops-logs"
}
