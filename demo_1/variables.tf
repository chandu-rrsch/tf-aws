variable "region" {
  description = "aws region"
  default     = "ap-south-1"
}

variable "azs" {
  description = "list of availability zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "vpc-cidr" {
  description = "vpc cidr"
  default     = "11.0.0.0/16"
}

variable "public-subnet-cidrs" {
  description = "list of public subnet cidrs"
  type        = list(string)
  default     = ["11.0.1.0/24", "11.0.2.0/24", "11.0.3.0/24"]
}

variable "private-subnet-cidrs" {
  description = "list of private subnet cidrs"
  type        = list(string)
  default     = ["11.0.10.0/24", "11.0.11.0/24", "11.0.12.0/24", "11.0.13.0/24"]
}

variable "instance-count" {
  description = "number of ec2 instances"
  default     = 2
}