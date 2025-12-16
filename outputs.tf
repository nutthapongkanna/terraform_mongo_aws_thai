output "public_ip" {
  value = aws_instance.mongo.public_ip
}

output "ssh_cmd" {
  value = "ssh -i ~/.ssh/th-mongo ubuntu@${aws_instance.mongo.public_ip}"
}

output "mongo_root_username" {
  value = var.mongo_root_username
}

output "mongo_root_password" {
  value     = random_password.mongo_root.result
  sensitive = true
}

output "mongo_app_username" {
  value = var.mongo_app_username
}

output "mongo_app_password" {
  value     = random_password.mongo_app.result
  sensitive = true
}

output "mongo_root_uri" {
  value     = "mongodb://${var.mongo_root_username}:${random_password.mongo_root.result}@${aws_instance.mongo.public_ip}:${var.mongo_port}/admin?authSource=admin"
  sensitive = true
}

output "mongo_app_uri" {
  value     = "mongodb://${var.mongo_app_username}:${random_password.mongo_app.result}@${aws_instance.mongo.public_ip}:${var.mongo_port}/${var.mongo_database}?authSource=${var.mongo_database}"
  sensitive = true
}
