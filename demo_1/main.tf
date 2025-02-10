# =====================================================================================================================
# VPC
# =====================================================================================================================
resource "aws_vpc" "demo1" {
  cidr_block = var.vpc-cidr
  tags = {
    Name = "demo1"
  }
}

# =====================================================================================================================
# PUBLIC SUBNET
# =====================================================================================================================
resource "aws_subnet" "demo1_public" {
  count             = length(var.public-subnet-cidrs)
  vpc_id            = aws_vpc.demo1.id
  cidr_block        = var.public-subnet-cidrs[count.index]
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "demo1-pub-sub-${count.index}"
  }
}

# =====================================================================================================================
# PRIVATE SUBNET
# =====================================================================================================================
resource "aws_subnet" "demo1_private" {
  count             = length(var.private-subnet-cidrs)
  vpc_id            = aws_vpc.demo1.id
  cidr_block        = var.private-subnet-cidrs[count.index]
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "demo1-pri-sub-${count.index}"
  }
}

# =====================================================================================================================
# INTERNET GATEWAY
# =====================================================================================================================
resource "aws_internet_gateway" "demo1_ig" {
  vpc_id = aws_vpc.demo1.id
  tags = {
    Name = "demo1-ig"
  }
}

# =====================================================================================================================
# PUBLIC ROUTE TABLE
# =====================================================================================================================
resource "aws_route_table" "demo1_vpc_rt_pub" {
  vpc_id = aws_vpc.demo1.id
  tags = {
    Name = "demo1_pub_rt"
  }
}

# =====================================================================================================================
# PUBLIC ROUTE TABLE - IG ROUTE
# =====================================================================================================================
resource "aws_route" "demo1_rt1" {
  route_table_id = aws_route_table.demo1_vpc_rt_pub.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.demo1_ig.id
}

# =====================================================================================================================
# PUBLIC ROUTE TABLE ASSOCIATIONS
# =====================================================================================================================
resource "aws_route_table_association" "demo1_rt1_pub" {
  count = length(var.public-subnet-cidrs)
  route_table_id = aws_route_table.demo1_vpc_rt_pub.id
  subnet_id = aws_subnet.demo1_public[count.index].id
}

# =====================================================================================================================
# PRIVATE ROUTE TABLE
# =====================================================================================================================
resource "aws_route_table" "demo1_vpc_rt_pri" {
  vpc_id = aws_vpc.demo1.id
  tags = {
    Name = "demo1_pri_rt"
  }
}

# =====================================================================================================================
# PRIVATE ROUTE TABLE ASSOCIATIONS
# =====================================================================================================================
resource "aws_route_table_association" "demo1_rt1_pri" {
  count = length(var.private-subnet-cidrs)
  route_table_id = aws_route_table.demo1_vpc_rt_pri.id
  subnet_id = aws_subnet.demo1_private[count.index].id
}