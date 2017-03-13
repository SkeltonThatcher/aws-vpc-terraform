## VPC + Subnets + IGW

resource "aws_vpc" "main" {
  cidr_block           = "${var.cidr_prefix}.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags {
    Name = "${var.cidr_prefix}-vpc"
  }
}

resource "aws_subnet" "pub_a" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.cidr_prefix}.1.0/24"
  availability_zone = "${var.aws_region}a"
  map_public_ip_on_launch = "true"

  tags {
    Name = "${var.cidr_prefix}.1-pub-a"
  }
}

resource "aws_subnet" "pub_b" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.cidr_prefix}.2.0/24"
  availability_zone = "${var.aws_region}b"
  map_public_ip_on_launch = "true"

  tags {
    Name = "${var.cidr_prefix}.2-pub-b"
  }
}

resource "aws_subnet" "priv_a" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.cidr_prefix}.3.0/24"
  availability_zone = "${var.aws_region}a"

  tags {
    Name = "${var.cidr_prefix}.3-priv-a"
  }
}

resource "aws_subnet" "priv_b" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.cidr_prefix}.4.0/24"
  availability_zone = "${var.aws_region}b"

  tags {
    Name = "${var.cidr_prefix}.4-priv-b"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_route_table" "pub" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
}

resource "aws_route_table_association" "pub_a" {
  subnet_id      = "${aws_subnet.pub_a.id}"
  route_table_id = "${aws_route_table.pub.id}"
}

resource "aws_route_table_association" "pub_b" {
  subnet_id      = "${aws_subnet.pub_b.id}"
  route_table_id = "${aws_route_table.pub.id}"
}
