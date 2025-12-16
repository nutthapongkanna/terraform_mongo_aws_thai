output "public_ip" {
  value = aws_instance.mongo.public_ip
}

output "mongo_port" {
  value = var.mongo_port
}

output "ssh_cmd" {
  value = "ssh -i ~/.ssh/th-mongo ubuntu@${aws_instance.mongo.public_ip}"
}

output "mongo_uri" {
  value = "mongodb://${var.mongo_root_username}:${var.mongo_root_password}@${aws_instance.mongo.public_ip}:${var.mongo_port}/admin?authSource=admin"
  sensitive = true
}
