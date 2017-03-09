#====================
# VPC + Subnets + IGW
#====================

resource "aws_vpc" "main" {
  cidr_block           = "${var.CIDR_PREFIX}.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags {
    Name = "${var.SERVICE_NAME}-vpc"
  }
}

resource "aws_subnet" "publicA" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.CIDR_PREFIX}.1.0/24"
  availability_zone = "${var.AWS_REGION}a"
  map_public_ip_on_launch = "true"

  tags {
    Name = "${var.SERVICE_NAME}-publicA"
  }
}

resource "aws_subnet" "publicB" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.CIDR_PREFIX}.2.0/24"
  availability_zone = "${var.AWS_REGION}b"
  map_public_ip_on_launch = "true"

  tags {
    Name = "${var.SERVICE_NAME}-publicB"
  }
}

resource "aws_subnet" "privateA" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.CIDR_PREFIX}.3.0/24"
  availability_zone = "${var.AWS_REGION}a"

  tags {
    Name = "${var.SERVICE_NAME}-privateA"
  }
}

resource "aws_subnet" "privateB" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.CIDR_PREFIX}.4.0/24"
  availability_zone = "${var.AWS_REGION}b"

  tags {
    Name = "${var.SERVICE_NAME}-privateB"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_route_table" "publicRT" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
}

resource "aws_route_table_association" "publicA" {
  subnet_id      = "${aws_subnet.publicA.id}"
  route_table_id = "${aws_route_table.publicRT.id}"
}

resource "aws_route_table_association" "publicB" {
  subnet_id      = "${aws_subnet.publicB.id}"
  route_table_id = "${aws_route_table.publicRT.id}"
}
