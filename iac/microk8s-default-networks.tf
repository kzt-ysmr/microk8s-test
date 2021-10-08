
# VPCs
resource "aws_vpc" "default" {
  cidr_block = "172.16.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${terraform.workspace}-vpc-default-${local.proj}"
  }
}

# Internet Gateways
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "${terraform.workspace}-vpc-default-${local.proj}"
  }
}

# Route Tables
resource "aws_route_table" "default" {
  vpc_id = aws_vpc.default.id

  route = [
    {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.default.id
      carrier_gateway_id = ""
      destination_prefix_list_id = ""
      egress_only_gateway_id = ""
      instance_id = ""
      ipv6_cidr_block = ""
      local_gateway_id = ""
      nat_gateway_id = ""
      network_interface_id = ""
      transit_gateway_id = ""
      vpc_endpoint_id = ""
      vpc_peering_connection_id = ""
    }
  ]

  tags = {
    Name = "${terraform.workspace}-rt-defalut-${local.proj}"
  }
}
