####################### vpc ###########################
resource "aws_vpc" "vpca" {
  cidr_block = var.vpca
  tags = {
    Name = "VPC A"
  }
}

resource "aws_vpc" "vpcb" {
  cidr_block = var.vpcb
    tags = {
    Name = "VPC B"
  }
}

resource "aws_vpc" "vpcc" {
  cidr_block = var.vpcc
    tags = {
    Name = "VPC C"
  }
}
####################### subnets ###########################
data "aws_availability_zones" "azs" {
  state = "available"
} //[us-east-1a, us-east-1b, us-east-1c, us-east-1d]

data "aws_availability_zone" "az" {
  count = 4
  name = data.aws_availability_zones.azs.names[count.index]
}

resource "aws_subnet" "private_subnet_vpca" {
  vpc_id                  = aws_vpc.vpca.id
  count                   = 4
  cidr_block              = element(var.private_vpca_subnets_cidr, count.index)
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name        = "subnet-pv-${data.aws_availability_zone.az[count.index].name_suffix}"
  }
}

resource "aws_subnet" "public_subnet_vpca" {
  vpc_id                  = aws_vpc.vpca.id
  count                   = 4
  cidr_block              = element(var.public_vpca_subnets_cidr, count.index)
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name        = "subnet-pb-${data.aws_availability_zone.az[count.index].name_suffix}"
  }
}

resource "aws_subnet" "database_subnet_vpca" {
  vpc_id                  = aws_vpc.vpca.id
  count                   = 4
  cidr_block              = element(var.database_vpca_subnets_cidr, count.index)
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name        = "subnet-db-${data.aws_availability_zone.az[count.index].name_suffix}"
  }
}

resource "aws_subnet" "private_subnet_vpcb" {
  vpc_id                  = aws_vpc.vpcb.id
  count                   = 4
  cidr_block              = element(var.private_vpcb_subnets_cidr, count.index)
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name        = "subnet-pv-${data.aws_availability_zone.az[count.index].name_suffix}"
  }
}

resource "aws_subnet" "public_subnet_vpcb" {
  vpc_id                  = aws_vpc.vpcb.id
  count                   = 4
  cidr_block              = element(var.public_vpcb_subnets_cidr, count.index)
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name        = "subnet-pb-${data.aws_availability_zone.az[count.index].name_suffix}"
  }
}

resource "aws_subnet" "database_subnet_vpcb" {
  vpc_id                  = aws_vpc.vpcb.id
  count                   = 4
  cidr_block              = element(var.database_vpcb_subnets_cidr, count.index)
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name        = "subnet-db-${data.aws_availability_zone.az[count.index].name_suffix}"
  }
}

resource "aws_subnet" "private_subnet_vpcc" {
  vpc_id                  = aws_vpc.vpcc.id
  count                   = 4
  cidr_block              = element(var.private_vpcc_subnets_cidr, count.index)
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name        = "subnet-pv-${data.aws_availability_zone.az[count.index].name_suffix}"
  }
}

resource "aws_subnet" "public_subnet_vpcc" {
  vpc_id                  = aws_vpc.vpcc.id
  count                   = 4
  cidr_block              = element(var.public_vpcc_subnets_cidr, count.index)
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name        = "subnet-pb-${data.aws_availability_zone.az[count.index].name_suffix}"
  }
}

resource "aws_subnet" "database_subnet_vpcc" {
  vpc_id                  = aws_vpc.vpcc.id
  count                   = 4
  cidr_block              = element(var.database_vpcc_subnets_cidr, count.index)
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name        = "subnet-db-${data.aws_availability_zone.az[count.index].name_suffix}"
  }
}
####################### route_tables ###########################
resource "aws_internet_gateway" "gwa" {
  vpc_id = aws_vpc.vpca.id

  tags = {
    Name = "Gateway VPC A"
  }
}

resource "aws_internet_gateway" "gwb" {
  vpc_id = aws_vpc.vpcb.id

  tags = {
    Name = "Gateway VPC B"
  }
}

resource "aws_internet_gateway" "gwc" {
  vpc_id = aws_vpc.vpcc.id

  tags = {
    Name = "Gateway VPC C"
  }
}

resource "aws_route_table" "public_vpca" {
  vpc_id = aws_vpc.vpca.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gwa.id
  }

  tags = {
    Name = "public_vpca"
  }
}

resource "aws_route_table_association" "subnet_public_vpca" {
  count = 4
  subnet_id      = aws_subnet.public_subnet_vpca[count.index].id
  route_table_id = aws_route_table.public_vpca.id
}

resource "aws_route_table" "public_vpcb" {
  vpc_id = aws_vpc.vpcb.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gwb.id
  }

  tags = {
    Name = "public_vpcb"
  }
}

resource "aws_route_table_association" "subnet_public_vpcb" {
  count = 4
  subnet_id      = aws_subnet.public_subnet_vpcb[count.index].id
  route_table_id = aws_route_table.public_vpcb.id
}

resource "aws_route_table" "public_vpcc" {
  vpc_id = aws_vpc.vpcc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gwc.id
  }

  tags = {
    Name = "public_vpcc"
  }
}

resource "aws_route_table_association" "subnet_public_vpcc" {
  count = 4
  subnet_id      = aws_subnet.public_subnet_vpcc[count.index].id
  route_table_id = aws_route_table.public_vpcc.id
}
###################### private route #########################
resource "aws_route_table" "private_vpca" {
  vpc_id = aws_vpc.vpca.id
  route {
      cidr_block = var.vpcb
      vpc_peering_connection_id = aws_vpc_peering_connection.vpca_vpcb.id
  }
  route {
        cidr_block = var.vpcc
        vpc_peering_connection_id = aws_vpc_peering_connection.vpca_vpcc.id
  }

  tags = {
    Name = "private_vpca"
  }
}

resource "aws_route_table_association" "subnet_private_vpca" {
  count = 4
  subnet_id      = aws_subnet.private_subnet_vpca[count.index].id
  route_table_id = aws_route_table.private_vpca.id
}

resource "aws_route_table" "private_vpcb" {
  vpc_id = aws_vpc.vpcb.id
  route {
        cidr_block = var.vpca
        vpc_peering_connection_id = aws_vpc_peering_connection.vpca_vpcb.id
  }

  tags = {
    Name = "private_vpcb"
  }
}

resource "aws_route_table_association" "subnet_private_vpcb" {
  count = 4
  subnet_id      = aws_subnet.private_subnet_vpcb[count.index].id
  route_table_id = aws_route_table.private_vpcb.id
}

resource "aws_route_table" "private_vpcc" {
  vpc_id = aws_vpc.vpcc.id
  route {
        cidr_block = var.vpca
        vpc_peering_connection_id = aws_vpc_peering_connection.vpca_vpcc.id
  }

  tags = {
    Name = "private_vpcc"
  }
}

resource "aws_route_table_association" "subnet_private_vpcc" {
  count = 4
  subnet_id      = aws_subnet.private_subnet_vpcc[count.index].id
  route_table_id = aws_route_table.private_vpcc.id
}
###########################################################
resource "aws_route_table_association" "database_subnet_vpca" {
  count = 4
  subnet_id      = aws_subnet.database_subnet_vpca[count.index].id
  route_table_id = aws_route_table.private_vpca.id
}
resource "aws_route_table_association" "database_subnet_vpcb" {
  count = 4
  subnet_id      = aws_subnet.database_subnet_vpcb[count.index].id
  route_table_id = aws_route_table.private_vpcb.id
}
resource "aws_route_table_association" "database_subnet_vpcc" {
  count = 4
  subnet_id      = aws_subnet.database_subnet_vpcc[count.index].id
  route_table_id = aws_route_table.private_vpcc.id
}
####################### peerings ###########################
resource "aws_vpc_peering_connection" "vpca_vpcb" {
  peer_vpc_id   = aws_vpc.vpcb.id
  vpc_id        = aws_vpc.vpca.id
  auto_accept   = true

  tags = {
    "Name" = "VPC Peering entre A e B"
  }
}

resource "aws_vpc_peering_connection" "vpca_vpcc" {
  peer_vpc_id   = aws_vpc.vpcc.id
  vpc_id        = aws_vpc.vpca.id
  auto_accept   = true

  tags = {
    "Name" = "VPC Peering entre A e C"
  }
}
################ transit gateway #################
resource "aws_ec2_transit_gateway" "default_transit_gateway" {

  tags = {
    "Name" = "default_transit_gateway"
  }
}

data "aws_subnet_ids" "vpca" {
  vpc_id = aws_vpc.vpca.id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpca" {
  subnet_ids         = data.aws_subnet_ids.vpca.ids
  transit_gateway_id = aws_ec2_transit_gateway.default_transit_gateway.id
  vpc_id             = aws_vpc.vpca.id
}

data "aws_subnet_ids" "vpcb" {
  vpc_id = aws_vpc.vpcb.id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpcb" {
  subnet_ids         = data.aws_subnet_ids.vpcb.ids
  transit_gateway_id = aws_ec2_transit_gateway.default_transit_gateway.id
  vpc_id             = aws_vpc.vpcb.id
}

data "aws_subnet_ids" "vpcc" {
  vpc_id = aws_vpc.vpcc.id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpcc" {
  subnet_ids         = data.aws_subnet_ids.vpcc.ids
  transit_gateway_id = aws_ec2_transit_gateway.default_transit_gateway.id
  vpc_id             = aws_vpc.vpcc.id
}
