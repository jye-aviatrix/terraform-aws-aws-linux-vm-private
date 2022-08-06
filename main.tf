data "aws_ami" "ubuntu_20_04_lts" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}


resource "aws_security_group" "this" {
  name        = "${var.vm_name} allow inbound SSH and ping from anywhere"
  description = "${var.vm_name} allow inbound SSH and ping from anywhere"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description      = "Allow_All_Out_Bound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = local.tags
}

resource "aws_network_interface" "this" {
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.this.id]

  tags = local.tags
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu_20_04_lts.id
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.this.id
    device_index         = 0
  }

  key_name = var.key_name
  tags     = local.tags

}