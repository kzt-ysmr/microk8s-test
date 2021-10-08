
# AMIs
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Key-Pairs
resource "aws_key_pair" "backend" {
  key_name   = "${terraform.workspace}-kp-backend-${local.proj}"
  public_key = file("./.ssh/${terraform.workspace}-kp-backend-${local.proj}.pub")
}

# Instances
resource "aws_instance" "backend" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.xlarge"
  subnet_id     = aws_subnet.backend.id
  key_name      = aws_key_pair.backend.id

  vpc_security_group_ids = [
    aws_security_group.backend.id
  ]

  provisioner "remote-exec" {
    script = "./remote-exec/init.sh"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = self.public_ip
    private_key = file("./.ssh/${terraform.workspace}-kp-backend-${local.proj}")
  }

  tags = {
    Name = "${terraform.workspace}-ec2-backend-${local.proj}"
  }
}

# Elastic IP
resource "aws_eip" "backend" {
  vpc      = true

  tags = {
    Name = "${terraform.workspace}-eip-backend-${local.proj}"
  }
}

# Elastic IP Association
resource "aws_eip_association" "backend" {
  instance_id   = aws_instance.backend.id
  allocation_id = aws_eip.backend.id
}
