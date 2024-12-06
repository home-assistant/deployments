resource "aws_vpc" "network" {
  cidr_block           = var.network_cidr
  enable_dns_hostnames = true

  tags = {
    Region = data.aws_region.current.name
  }
}

resource "aws_internet_gateway" "gw_internet" {
  vpc_id = aws_vpc.network.id

  tags = {
    Region = data.aws_region.current.name
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.network.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_internet.id
  }

  tags = {
    Region = data.aws_region.current.name
    Zone   = "public"
  }
}

resource "aws_eip" "nat" {
  count = 2

  domain = "vpc"

  tags = {
    Region = data.aws_region.current.name
  }

  depends_on = [aws_internet_gateway.gw_internet]
}

resource "aws_nat_gateway" "gw_nat" {
  count = 2

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Region = data.aws_region.current.name
  }
}

resource "aws_route_table" "private" {
  count = 2

  vpc_id = aws_vpc.network.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw_nat[count.index].id
  }

  tags = {
    Region = data.aws_region.current.name
    Zone   = "private"
  }
}
