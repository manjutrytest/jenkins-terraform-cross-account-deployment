output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.main.id
}

output "instance_private_ip" {
  description = "Private IP address"
  value       = aws_instance.main.private_ip
}

output "instance_public_ip" {
  description = "Public IP address"
  value       = aws_instance.main.public_ip
}

output "elastic_ip" {
  description = "Elastic IP address"
  value       = var.allocate_eip ? aws_eip.main[0].public_ip : null
}
