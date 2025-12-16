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
  description = "ใส่ public key (เช่น ~/.ssh/th-mongo.pub)"
}

# (ตามที่ขอ test) เปิด SSH จากทุกที่ได้ แต่แนะนำให้เปลี่ยนเป็น IP ตัวเอง/32
variable "ssh_allowed_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "mongo_port" {
  type    = number
  default = 27017
}

# (ตามที่ขอ) เปิด Mongo ออก internet
variable "mongo_allowed_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

# users + db
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

# สุ่มรหัสผ่านแบบไม่มี special
variable "password_length" {
  type    = number
  default = 24
}
