
## Ec2 - instance creation terraform module

resource "aws_instance" "roboshop" {
  count                  = 4
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_all.id] ## it means it will take sg id from mentioned secutirty group

  tags = {
    Name = var.instances[count.index]
  }
}

## Below are the Security gropus creation terraform modules

resource "aws_security_group" "allow_all" {
  name        = var.sg_name
  description = var.sg_description


  ingress {
    from_port        = var.from_port
    to_port          = var.to_port
    protocol         = "-1"
    cidr_blocks      = var.cidr_blocks
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = var.from_port
    to_port          = var.to_port
    protocol         = "-1"
    cidr_blocks      = var.cidr_blocks
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.sg_tags
}