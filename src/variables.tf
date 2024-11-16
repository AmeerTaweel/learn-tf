variable "aws-access-key" {
  type      = string
  sensitive = true
}

variable "aws-secret-key" {
  type      = string
  sensitive = true
}

variable "aws-region" {
  type        = string
  default     = "use-east-2"
  sensitive   = false
  description = "This is the AWS region"
}
