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
  availability_zone       = "us-east-1a"

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