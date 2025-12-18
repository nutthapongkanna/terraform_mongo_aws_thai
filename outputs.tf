# ----------------------------
# DEV VM
# ----------------------------
output "dev_public_ip" {
  description = "Public IP of dev VM"
  value       = aws_instance.dev.public_ip
}

output "dev_private_ip" {
  description = "Private IP of dev VM"
  value       = aws_instance.dev.private_ip
}

# ----------------------------
# MONGO VM
# ----------------------------
output "mongo_public_ip" {
  description = "Public (external) IP of mongo VM"
  value       = aws_instance.mongo.public_ip
}

output "mongo_private_ip" {
  description = "Private (internal) IP of mongo VM"
  value       = aws_instance.mongo.private_ip
}

# ----------------------------
# Mongo URIs
# ----------------------------
output "mongo_uri_internal" {
  description = "MongoDB URI via internal/private IP"
  value = "mongodb://${var.mongo_app_username}:${random_password.mongo_app.result}@${aws_instance.mongo.private_ip}:${var.mongo_port}/${var.mongo_database}"
  sensitive = true
}

output "mongo_uri_external" {
  description = "MongoDB URI via public/external IP"
  value = "mongodb://${var.mongo_app_username}:${random_password.mongo_app.result}@${aws_instance.mongo.public_ip}:${var.mongo_port}/${var.mongo_database}"
  sensitive = true
}
