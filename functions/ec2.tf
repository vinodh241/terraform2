
## Ec2 - instance creation terraform module

resource "aws_instance" "roboshop" {
  #for_each= var.instances
  count = length(var.instances)
  ami                    = var.ami_id
  instance_type          = "t3.micro"
  # instance_type = each.key
  vpc_security_group_ids = [aws_security_group.allow_all.id] ## it means it will take sg id from mentioned secutirty group

  tags = merge(
    var.common_tags,
    {
    Component = var.instances[count.index]
    Name = var.instances[count.index]
  }
  )

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

  tags = merge(
    var.common_tags,
    {
      Name = "allow-all"
    }
  )
}