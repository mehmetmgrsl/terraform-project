# Create a VPC
resource "aws_vpc" "mmg-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "dev-vpc"
  }
}


resource "aws_subnet" "mmg-public-subnet" {
  vpc_id                  = aws_vpc.mmg-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-north-1a"

  tags = {
    Name = "dev-public-subnet"
  }
}


resource "aws_internet_gateway" "mmg-gw" {
  vpc_id = aws_vpc.mmg-vpc.id

  tags = {
    Name = "dev-gw"
  }
}

resource "aws_route_table" "mmg-public-rt" {
  vpc_id = aws_vpc.mmg-vpc.id

  tags = {
    Name = "dev-public-rt"
  }
}


resource "aws_route" "mmg-default-rt" {
  route_table_id         = aws_route_table.mmg-public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mmg-gw.id
}

resource "aws_route_table_association" "mmg-public-assoc" {
  subnet_id      = aws_subnet.mmg-public-subnet.id
  route_table_id = aws_route_table.mmg-public-rt.id
}


resource "aws_security_group" "mmg_sg" {
  name        = "dev_sg"
  description = "dev security group"
  vpc_id      = aws_vpc.mmg-vpc.id

  ingress {
    description = "Allow all inbound traffic from any destination"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic to any destination"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


resource "aws_key_pair" "mmg_auth" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/mmgkey.pub")
}


resource "aws_instance" "mmg_dev_node" {
  ami                    = data.aws_ami.mmg_server_ami.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.mmg_auth.id
  vpc_security_group_ids = [aws_security_group.mmg_sg.id]
  subnet_id              = aws_subnet.mmg-public-subnet.id

  user_data = file("userdata.tpl")

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "dev-node"
  }
}

