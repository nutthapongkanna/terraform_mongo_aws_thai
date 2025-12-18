aws_region   = "ap-southeast-7"
project_name = "mongo-internal"

vpc_cidr    = "10.10.0.0/24"
subnet_cidr = "10.10.0.0/24"

# OS
ubuntu_version = "22.04"

# SSH
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQ..."
ssh_allowed_cidrs = [
  "/32"
]

# DEV VM
dev_instance_type = "t3.micro"
dev_disk_gb       = 20

# MONGO VM
mongo_instance_type = "t3.small"
mongo_disk_gb       = 50

mongo_port = 27017

mongo_root_username = ""
mongo_app_username  = ""
mongo_database      = ""

password_length = 24
