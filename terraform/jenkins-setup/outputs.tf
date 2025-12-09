output "jenkins_url" {
  description = "Jenkins URL"
  value       = module.jenkins.jenkins_url
}

output "jenkins_public_ip" {
  description = "Jenkins public IP"
  value       = module.jenkins.jenkins_public_ip
}

output "jenkins_instance_id" {
  description = "Jenkins instance ID"
  value       = module.jenkins.jenkins_instance_id
}

output "state_bucket_name" {
  description = "Terraform state bucket name"
  value       = aws_s3_bucket.terraform_state.id
}

output "vpc_id" {
  description = "Jenkins VPC ID"
  value       = module.jenkins_vpc.vpc_id
}

output "initial_password_command" {
  description = "Command to get Jenkins initial password"
  value       = "aws ssm start-session --target ${module.jenkins.jenkins_instance_id} --region ${var.aws_region}"
}
