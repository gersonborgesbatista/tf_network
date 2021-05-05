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
# route {
#     cidr_block = var.vpcb
#     vpc_peering_connection_id = aws_vpc_peering_connection.vpca_vpcb.id
# }
# route {
#       cidr_block = var.vpcc
#       vpc_peering_connection_id = aws_vpc_peering_connection.vpca_vpcc.id
# } #Rotas do transit gateway já aplicadas abaixo.
  route {
        cidr_block = var.vpcb
        transit_gateway_id = aws_ec2_transit_gateway.ex4_transit_gateway.id
        }
  route {
        cidr_block = var.vpcc
        transit_gateway_id = aws_ec2_transit_gateway.ex4_transit_gateway.id
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
# route {
#       cidr_block = var.vpca
#       vpc_peering_connection_id = aws_vpc_peering_connection.vpca_vpcb.id
# } #Rotas do transit gateway já aplicadas abaixo.

  route {
        cidr_block = var.vpca
        transit_gateway_id = aws_ec2_transit_gateway.ex4_transit_gateway.id
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
# route {
#       cidr_block = var.vpca
#       vpc_peering_connection_id = aws_vpc_peering_connection.vpca_vpcc.id
# } #Rotas do transit gateway já aplicadas abaixo.
  route {
        cidr_block = var.vpca
        transit_gateway_id = aws_ec2_transit_gateway.ex4_transit_gateway.id
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
##################### database rt associations ######################
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
################ transit gateway - número 3 #################
resource "aws_ec2_transit_gateway" "ex3_transit_gateway" {

  tags = {
    "Name" = "ex3_transit_gateway"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpca" {
  subnet_ids         = aws_subnet.private_subnet_vpca.*.id
  transit_gateway_id = aws_ec2_transit_gateway.ex3_transit_gateway.id
  vpc_id             = aws_vpc.vpca.id
  transit_gateway_default_route_table_association = true

  tags = {
    "Name" = "vpcA"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpcb" {
  subnet_ids         = aws_subnet.private_subnet_vpcb.*.id
  transit_gateway_id = aws_ec2_transit_gateway.ex3_transit_gateway.id
  vpc_id             = aws_vpc.vpcb.id
  transit_gateway_default_route_table_association = true

  tags = {
    "Name" = "vpcB"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpcc" {
  subnet_ids         = aws_subnet.private_subnet_vpcc.*.id
  transit_gateway_id = aws_ec2_transit_gateway.ex3_transit_gateway.id
  vpc_id             = aws_vpc.vpcc.id
  transit_gateway_default_route_table_association = true

  tags = {
    "Name" = "vpcC"
  }
}
############################## número 4 ##########################################
resource "aws_ec2_transit_gateway" "ex4_transit_gateway" {

  tags = {
    "Name" = "ex4_transit_gateway"
  }
}
## transit gw vpca 
resource "aws_ec2_transit_gateway_vpc_attachment" "vpcaex4" {
  subnet_ids         = aws_subnet.private_subnet_vpca.*.id
  transit_gateway_id = aws_ec2_transit_gateway.ex4_transit_gateway.id
  vpc_id             = aws_vpc.vpca.id
  transit_gateway_default_route_table_association = false

  tags = {
    "Name" = "vpcAex4"
  }
}
## transit gw vpcb
resource "aws_ec2_transit_gateway_vpc_attachment" "vpcbex4" {
  subnet_ids         = aws_subnet.private_subnet_vpcb.*.id
  transit_gateway_id = aws_ec2_transit_gateway.ex4_transit_gateway.id
  vpc_id             = aws_vpc.vpcb.id
  transit_gateway_default_route_table_association = false

  tags = {
    "Name" = "vpcBex4"
  }
}
## transit gw vpcc
resource "aws_ec2_transit_gateway_vpc_attachment" "vpccex4" {
  subnet_ids         = aws_subnet.private_subnet_vpcc.*.id
  transit_gateway_id = aws_ec2_transit_gateway.ex4_transit_gateway.id
  vpc_id             = aws_vpc.vpcc.id
  transit_gateway_default_route_table_association = false

  tags = {
    "Name" = "vpcCex4"
  }
}
## Criar 3 tabelas de roteamento no transit-gateway (uma para cada VPC)
resource "aws_ec2_transit_gateway_route_table" "vpca" {
  transit_gateway_id = aws_ec2_transit_gateway.ex4_transit_gateway.id
  
  tags = {
      "Name"= "Transit Gateway Route Table VPC A"
  }
}

resource "aws_ec2_transit_gateway_route" "rtvpca" {
  destination_cidr_block         = var.vpca
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpcaex4.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpca.id
}

resource "aws_ec2_transit_gateway_route_table_association" "vpca" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpcaex4.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpca.id
}

resource "aws_ec2_transit_gateway_route_table" "vpcb" {
  transit_gateway_id = aws_ec2_transit_gateway.ex4_transit_gateway.id

  tags = {
      "Name"= "Transit Gateway Route Table VPC B"
  }
}

resource "aws_ec2_transit_gateway_route" "rtvpcb" {
  destination_cidr_block         = var.vpcb
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpcbex4.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpcb.id
}

resource "aws_ec2_transit_gateway_route_table_association" "vpcb" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpcbex4.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpcb.id
}

resource "aws_ec2_transit_gateway_route_table" "vpcc" {
  transit_gateway_id = aws_ec2_transit_gateway.ex4_transit_gateway.id

  tags = {
      "Name"= "Transit Gateway Route Table VPC C"
  }
}

resource "aws_ec2_transit_gateway_route" "rtvpcc" {
  destination_cidr_block         = var.vpcc
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpccex4.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpcc.id
}

resource "aws_ec2_transit_gateway_route_table_association" "vpcc" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpccex4.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpcc.id
}

## propagation
resource "aws_ec2_transit_gateway_route_table_propagation" "vpca" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpcaex4.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpca.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "vpcb" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpcbex4.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpcb.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "vpcc" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpccex4.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpcc.id
}

## VPC A fala com VPC B e C
resource "aws_ec2_transit_gateway_route" "vpca-b" {
  destination_cidr_block         = var.vpcb
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpcaex4.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpca.id
}

resource "aws_ec2_transit_gateway_route" "vpca-c" {
  destination_cidr_block         = var.vpcc
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpcaex4.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpca.id
}

## VPC B fala com VPC A
resource "aws_ec2_transit_gateway_route" "vpcb-a" {
  destination_cidr_block         = var.vpca
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpcbex4.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpcb.id
}
## VPC C fala com VPC A
resource "aws_ec2_transit_gateway_route" "vpcc-a" {
  destination_cidr_block         = var.vpca
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpccex4.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpcc.id
}
############################# vpn ################################
resource "aws_customer_gateway" "vpca-vpn" {
  bgp_asn    = 65000
  ip_address = "8.8.4.4" # insira seu ip público aqui
  type       = "ipsec.1"
}

resource "aws_vpn_connection" "vpca-vpn" {
  customer_gateway_id = aws_customer_gateway.vpca-vpn.id
  transit_gateway_id  = aws_ec2_transit_gateway.ex4_transit_gateway.id
  type                = aws_customer_gateway.vpca-vpn.type
}

