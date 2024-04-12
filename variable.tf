variable "instance_type" {
  description = "The type of instance to use for the build."
  default     = "t2.micro"
}

variable "key_pair" {
  default = "packer-testnrod"
}

variable "ssh_username" {
  description = "The username to use for SSH access to the instance."
  default     = "ec2-user"
}



variable "region" {
  description = "The AWS region where the build will take place."
  default     = "us-east-1"
}

variable "owners" {
  description = "The owner ID of the source AMI."
  default     = "099720109477"
}

variable "profile" {
  type        = string
  description = "The AWS CLI profile name to use for the build."
  default     = "shared-services"
}



variable "vpc_id" {
  type        = string
  description = "The ID of the VPC within which the build will occur."
  default     = "vpc-0176e5a84b0d1f93f"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet within which the build will occur."
  default     = "subnet-00d28f0a25745d2e4"
}

variable "ami" {
  type        = string
  description = "Application Image to Deploy"
}



variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to the resource."
  default = {
    "NAME"       = "packer-rhel9-aws"
    "OS_Version" = "RHEL"
    "Created-by" = "terraform"
  }

}
variable "environment" {
  default = "dev"
}