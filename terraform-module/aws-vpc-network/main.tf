/**
* VPC Network module
*/

resource "aws_internet_gateway" "igw"{
    vpc_id = var.vpc_id

    tags = merge(
    var.tags,
    {
      Name        = "${var.tags.service}-${var.tags.environment}-igw"
      description = "VPC Internet Gateway"
    }
  )
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = var.vpc_id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    var.elb_public_subnet_tags,
    {
      Name        = "${var.tags.service}-${var.tags.environment}-public-subnet-${count.index}"
      description = "Public subnet for EKS ELB"
    }
  )
}


resource "aws_eip" "nat" {
  domain   = "vpc"

  tags = merge(
    var.tags,
    {
      Name        = "${var.tags.service}-${var.tags.environment}-nat"
      description = "Elastic IP resource"
    }
  )
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public[0].id

  tags = merge(
    var.tags,
    {
      Name        = "${var.tags.service}-${var.tags.environment}-nat"
      description = "VPC NAT Gateway"
    }
  )

  depends_on = [ 
    aws_internet_gateway.igw
  ]
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    var.tags,
    {
      Name                                                                        = "${var.tags.service}-${var.tags.environment}-public-subnet-route-table"
      description                                                                 = "Public subnet route table for EKS ELB"
      "kubernetes.io/cluster/${var.tags.service}-${var.tags.environment}-cluster" = "owned"
    }
  )
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}


# private subnets
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id                  = var.vpc_id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = var.private_subnet_cidrs[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    var.elb_private_subnet_tags,
    {
      Name                                                                        = "${var.tags.service}-${var.tags.environment}-private-subnet-${count.index}"
      description                                                                 = "Private subnet for EKS node-group"
      "kubernetes.io/cluster/${var.tags.service}-${var.tags.environment}-cluster" = "owned"
    }
  )
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = merge(
    var.tags,
    {
      Name                                                                        = "${var.tags.service}-${var.tags.environment}-private-subnet-route-table"
      description                                                                 = "Public subnet route table for EKS ELB"
      "kubernetes.io/cluster/${var.tags.service}-${var.tags.environment}-cluster" = "owned"
    }
  )
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}