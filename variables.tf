# ----------------------------
# AWS / Project
# ----------------------------
variable "aws_region" {
  type = string
}

variable "project_name" {
  type = string
}

# ----------------------------
# Network
# ----------------------------
variable "vpc_cidr" {
  type = string
}

variable "subnet_cidr" {
  type = string
}

# ----------------------------
# Ubuntu AMI
# ----------------------------
variable "ubuntu_owner" {
  type    = string
  default = "099720109477" # Canonical
}

variable "ubuntu_version" {
  type        = string
  description = "Ubuntu version string, e.g. 22.04"
  default     = "22.04"
}

# ----------------------------
# SSH
# ----------------------------
variable "ssh_public_key" {
  type = string
}

variable "ssh_allowed_cidrs" {
  type        = list(string)
  description = "CIDRs allowed to SSH into dev/mongo"
}

# ----------------------------
# VPN external -> Mongo
# ----------------------------
variable "vpn_allowed_cidrs" {
  type        = list(string)
  description = "Public VPN egress IPs allowed to access Mongo public IP:27017"
  default     = []
}

# ----------------------------
# DEV VM sizing
# ----------------------------
variable "dev_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "dev_disk_gb" {
  type    = number
  default = 20
}

# ----------------------------
# MONGO VM sizing
# ----------------------------
variable "mongo_instance_type" {
  type    = string
  default = "t3.small"
}

variable "mongo_disk_gb" {
  type    = number
  default = 50
}

# ----------------------------
# Mongo config
# ----------------------------
variable "mongo_port" {
  type    = number
  default = 27017
}

variable "mongo_root_username" {
  type    = string
  default = "root"
}

variable "mongo_app_username" {
  type    = string
  default = "appuser"
}

variable "mongo_database" {
  type    = string
  default = "databasetest"
}

# ----------------------------
# Password
# ----------------------------
variable "password_length" {
  type    = number
  default = 24
}
