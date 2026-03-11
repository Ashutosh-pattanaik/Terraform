#  to create a ec2 we must have a ssh key. create a key using cmd:- ssh-keygen. then give a name to it.
#  .pub key will be the key kept in ec2-instance use to login it will be in the ec2( Public Key) 
#  the normal key will be with users which is used to login (private key just like .pem file)

resource "aws_key_pair" "conkey" {
  key_name   = "terraform-key"
  public_key = file("terrakey.pub")
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_security_group" "default" {
     vpc_id = aws_default_vpc.default.id

  ingress {
    protocol  = "tcp"
    self      = true  #Allow traffic from instances with the same security group
    from_port = 22
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP open"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #-1 means all ports range
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "terraformfirst" {
  ami           = "ami-01b6d88af12965bb6"
  instance_type = "t3.micro"
  key_name = aws_key_pair.conkey.key_name
  vpc_security_group_ids = [aws_default_security_group.default.id]
  tags = {
    Name = "created from terraform"
  }
 root_block_device { # root volume storage
    volume_size = 10 
    volume_type = "gp3"
  }
  connection { #connection block = SSH/WinRM login details for Terraform to access the server and run command used for user data.
    type        = "ssh"
    user        = "ec-user"
    private_key = file("terrakey")
    host        = self.public_ip
  }
}
