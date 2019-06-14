resource "aws_vpc" "myVpc" {
  cidr_block = var.cidrblock
  tags = {
    Name = "MyVPC"
  }
}
resource "aws_subnet" "subnets" {
  count = 2
  cidr_block = "${element(var.subnet_cidrblock, count.index)}"
  vpc_id = "${aws_vpc.myVpc.id}"
  tags = {
    Name = "${element(var.subnetnames,count.index)}"
  }
}
resource "aws_internet_gateway" "IGW" {
  vpc_id = "${aws_vpc.myVpc.id}"
}
resource "aws_route_table" "public_rtb" {
  vpc_id = "${aws_vpc.myVpc.id}"
  route {
    cidr_block = var.alltraffic
    gateway_id = "${aws_internet_gateway.IGW.id}"
  }
  tags = {
    Name = "Public Route Table"
  }
}
resource "aws_route_table_association" "pub_rtb_assoc" {
  route_table_id = "${aws_route_table.public_rtb.id}"
  subnet_id = "${aws_subnet.subnets[0].id}"
}
resource "aws_route_table" "private_rtb" {
  vpc_id = "${aws_vpc.myVpc.id}"
  tags = {
    Name = "Private Route Table"
  }
}
resource "aws_route_table_association" "pvt_rtb_assoc" {
  route_table_id = "${aws_route_table.private_rtb.id}"
  subnet_id = "${aws_subnet.subnets[1].id}"
}

resource "aws_security_group" "ins-sg" {
  name        = "allow_ssh_http"
  description = "Allow inbound SSH and HTTP traffic"
  vpc_id = "${aws_vpc.myVpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.alltraffic]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.alltraffic]
  }
  tags = {
    Name = "allow_ssh_http"
  }
}