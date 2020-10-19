variable "aws_region" {
  description = "The AWS region that resources will be created in."
  default     = "us-west-1"
}
variable "region" {
  default     = "us-west-1"
  type        = string
  description = "VPC Region"
}
variable "cidr_block" {
  default     = "10.0.0.0/16"
  type        = string
  description = "VPC CIDR block"
}

variable "public_subnet_cidr_blocks" {
  default     = ["10.0.0.0/24"]
  type        = list
  description = "Public subnet CIDR block"
}

variable "private_subnet_cidr_blocks" {
  default     = ["10.0.1.0/24"]
  type        = list
  description = "Private subnet CIDR block"
}

variable "availability_zones" {
  default     = ["us-west-1a"]
  type        = list
  description = "Availability zone for environment"
}