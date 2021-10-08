
# Subnets
resource "aws_subnet" "backend" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${terraform.workspace}-subnet-backend-${local.proj}"
  }
}

# Route Table Associations
resource "aws_route_table_association" "backend" {
  subnet_id      = aws_subnet.backend.id
  route_table_id = aws_route_table.default.id
}

# Security Groups
resource "aws_security_group" "backend" {
  name   = "${terraform.workspace}-sg-backend-${local.proj}"
  vpc_id = aws_vpc.default.id

  ingress = [
    {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = true
    }
  ]

  egress = [
    {
      description      = "ANY"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = true
    }
  ]

  tags = {
    Name = "${terraform.workspace}-sg-backend-${local.proj}"
  }
}
