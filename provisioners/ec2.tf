
## Ec2 - instance creation terraform module

resource "aws_instance" "roboshop" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_all.id] ## it means it will take sg id from mentioned secutirty group

  tags = var.ec2_tags


  ## LOCAL EXEC

 provisioner "local-exec" {
  command = "${self.private_ip} > inventory"
  on_failure = continue  # if any error's occur's in that case it will run with out any failure
   
 }

  provisioner "local-exec" {
  command = " echo server's ip is ${self.private_ip} > inventory"
  when = destroy  
   
 }

## REMOTE-EXE 
# Connection block to define SSH access details
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user" # Default user for ec2-user AMIs
    password  =  "DevOps321"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install nginx -y",
      "sudo systemctl start nginx",
    ]
  }
  
   provisioner "remote-exec" {
    when = destroy
    inline = [
      "sudo systemctl stop nginx",
    ]
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