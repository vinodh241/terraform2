variable "ami_id" {
  type        = string
  default     = "ami-09c813fb71547fc4f"
  description = "AMI ID of joindevops RHEL9"

}

variable "instance_type" {
  default = "t3.micro"

}

variable "ec2_tags" {
  default = {
    Name    = "Roboshop"
    purpose = "variables-demo"
  }


}

variable "sg_name" {
  default = "allowing-all"

}

variable "sg_description" {
  default = "alloiwng all ports from the internet"

}

variable "from_port" {
  default = 0

}

variable "to_port" {
  default = 0
  type    = number

}

variable "cidr_blocks" {
  type    = list(any)
  default = ["0.0.0.0/0"]
}

variable "sg_tags" {
  default = {
    Name = "allow-all"
  }

}


variable "instances" {
  # default = {
  #   mongodb = "t3.micro"
  #   redis = "t3.mirco"
  #   mysql = "t3.micro"
  #   rabbitmq = "t3.micro"


  # }
  default = ["mongodb" ,"redis","rabbitmq","mysql"]
}


variable "zone_id" {
  default = "Z0745757KP2VOJQE63F"

}

variable "domain_name" {

  default = "vinodh.site"
}

variable "ingress_ports" {
  default = [
    {
      from_port = 22
      to_port = 22
    },
        {
      from_port = 80
      to_port = 80
    },
        {
      from_port = 8080
      to_port = 8080
    }

  ]
  
}