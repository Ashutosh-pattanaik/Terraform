
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

