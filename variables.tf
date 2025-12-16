variable "aws_region" {
  type    = string
  default = "ap-southeast-7" # Thailand
}

variable "project_name" {
  type    = string
  default = "th-mongo-open"
}

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/24"
}

variable "subnet_cidr" {
  type    = string
  default = "10.10.0.0/24"
}

variable "instance_type" {
  type    = string
  default = "t3.small"
}

variable "disk_gb" {
  type    = number
  default = 30
}

variable "ssh_public_key" {
  type        = string
  description = "เนื้อหา public key เช่น ~/.ssh/th-mongo.pub"
}

variable "ssh_allowed_cidrs" {
  type        = list(string)
  default     = ["0.0.0.0/0"] # (ถ้าอยากปลอดภัย ให้เปลี่ยนเป็น IP ตัวเอง/32)
}

variable "mongo_port" {
  type    = number
  default = 27017
}

variable "mongo_allowed_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"] # ✅ ตามที่ขอ: เปิดให้ทุกคนเข้าถึงได้
}

variable "mongo_root_username" {
  type    = string
  default = "admin"
}

variable "mongo_root_password" {
  type      = string
  sensitive = true
}
