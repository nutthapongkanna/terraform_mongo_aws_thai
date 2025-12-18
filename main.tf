# =====================================================
# AMI : Ubuntu (FIX สำหรับ ap-southeast-7)
# - ใช้ hvm-ssd-gp3 + jammy (22.04)
# =====================================================
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = [var.ubuntu_owner] # Canonical

  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd-gp3/ubuntu-jammy-${var.ubuntu_version}-amd64-server-*"
    ]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

# =====================================================
# Passwords
# =====================================================
resource "random_password" "mongo_root" {
  length  = var.password_length
  special = false
}

resource "random_password" "mongo_app" {
  length  = var.password_length
  special = false
}

# =====================================================
# VPC / Subnet / Routing
# =====================================================
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "${var.project_name}-vpc" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "${var.project_name}-igw" }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true
  tags = { Name = "${var.project_name}-subnet-public" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = { Name = "${var.project_name}-rt-public" }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# =====================================================
# Key Pair
# =====================================================
resource "aws_key_pair" "this" {
  key_name   = "${var.project_name}-key"
  public_key = var.ssh_public_key
}

# =====================================================
# Security Group : DEV VM
# =====================================================
resource "aws_security_group" "dev_sg" {
  name   = "${var.project_name}-dev-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "SSH to dev"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_allowed_cidrs
  }

  egress {
    description = "all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.project_name}-dev-sg" }
}

# =====================================================
# Security Group : MONGO VM
# =====================================================
resource "aws_security_group" "mongo_sg" {
  name   = "${var.project_name}-mongo-sg"
  vpc_id = aws_vpc.main.id

  # 1) Internal: dev-vm -> mongo
  ingress {
    description     = "Mongo from dev-vm (internal)"
    from_port       = var.mongo_port
    to_port         = var.mongo_port
    protocol        = "tcp"
    security_groups = [aws_security_group.dev_sg.id]
  }

  # 2) External: VPN public IPs -> mongo public IP
  ingress {
    description = "Mongo from VPN external IPs"
    from_port   = var.mongo_port
    to_port     = var.mongo_port
    protocol    = "tcp"
    cidr_blocks = var.vpn_allowed_cidrs
  }

  # SSH (optional)
  ingress {
    description = "SSH to mongo"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_allowed_cidrs
  }

  egress {
    description = "all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.project_name}-mongo-sg" }
}

# =====================================================
# DEV VM
# =====================================================
resource "aws_instance" "dev" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.dev_instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.dev_sg.id]
  key_name               = aws_key_pair.this.key_name

  root_block_device {
    volume_size = var.dev_disk_gb
    volume_type = "gp3"
  }

  user_data = templatefile(
    "${path.module}/user_data/install_docker_dev_vm.sh.tftpl",
    {}
  )

  tags = { Name = "${var.project_name}-dev-vm" }
}

# =====================================================
# MONGO VM
# =====================================================
resource "aws_instance" "mongo" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.mongo_instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.mongo_sg.id]
  key_name               = aws_key_pair.this.key_name

  root_block_device {
    volume_size = var.mongo_disk_gb
    volume_type = "gp3"
  }

  user_data = templatefile(
    "${path.module}/user_data/install_docker_run_mongo.sh.tftpl",
    {
      mongo_port          = var.mongo_port
      mongo_root_username = var.mongo_root_username
      mongo_root_password = random_password.mongo_root.result
      mongo_database      = var.mongo_database
      mongo_app_username  = var.mongo_app_username
      mongo_app_password  = random_password.mongo_app.result
    }
  )

  tags = { Name = "${var.project_name}-mongo-vm" }
}
