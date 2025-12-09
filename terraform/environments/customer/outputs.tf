output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = module.ec2.instance_id
}

output "instance_private_ip" {
  description = "EC2 private IP"
  value       = module.ec2.instance_private_ip
}

output "instance_public_ip" {
  description = "EC2 public IP"
  value       = module.ec2.instance_public_ip
}

output "elastic_ip" {
  description = "Elastic IP"
  value       = module.ec2.elastic_ip
}
