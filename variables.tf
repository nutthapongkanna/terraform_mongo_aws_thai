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
# OS
# ----------------------------
variable "ubuntu_owner" {
  type    = string
  default = "099720109477"
}

variable "ubuntu_version" {
  type        = string
  description = "20.04 | 22.04 | 24.04"
}

# ----------------------------
# SSH
# ----------------------------
variable "ssh_public_key" {
  type = string
}

variable "ssh_allowed_cidrs" {
  type = list(string)
}

# ----------------------------
# DEV VM
# ----------------------------
variable "dev_instance_type" {
  type = string
}

variable "dev_disk_gb" {
  type = number
}

# ----------------------------
# MONGO VM
# ----------------------------
variable "mongo_instance_type" {
  type = string
}

variable "mongo_disk_gb" {
  type = number
}

variable "mongo_port" {
  type = number
}

variable "mongo_root_username" {
  type = string
}

variable "mongo_app_username" {
  type = string
}

variable "mongo_database" {
  type = string
}

# ----------------------------
# Password
# ----------------------------
variable "password_length" {
  type = number
}
