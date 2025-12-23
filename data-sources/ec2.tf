
## Ec2 - instance creation terraform module



resource "aws_instance" "roboshop" {
  ami                    = "data.aws_ami.joindevops.id"
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_all.id] ## it means it will take sg id from mentioned secutirty group

  tags = {
    Name = "Roboshop"
  }
}



## Below are the Security gropus creation terraform modules

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = " Allow all traffic"


  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow-all"
  }

}