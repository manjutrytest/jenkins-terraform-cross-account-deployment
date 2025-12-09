variable "jenkins_name" {
  description = "Name for Jenkins server"
  type        = string
  default     = "jenkins-server"
}

variable "instance_type" {
  description = "EC2 instance type for Jenkins"
  type        = string
  default     = "t3.medium"
}

variable "vpc_id" {
  description = "VPC ID for Jenkins"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for Jenkins"
  type        = string
}

variable "allowed_cidrs" {
  description = "CIDR blocks allowed to access Jenkins"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "state_bucket_name" {
  description = "S3 bucket name for Terraform state"
  type        = string
}
