packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}


variable "ami_prefix" {
  type        = string
  description = "Prefix for the AMI name to help identify it."
  default     = "packer-rhel9-image"
}

variable "source_ami_name" {
  description = "The name pattern of the source AMI to use for the build."
  default     = "RHEL-9*"
}

variable "instance_type" {
  description = "The type of instance to use for the build."
  default     = "t2.micro"
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
  default     = "309956199498"
}

variable "profile" {
  type        = string
  description = "The AWS CLI profile name to use for the build."
  default     = "shared-services"
}

variable "source_ami" {
  type        = string
  description = "The specific ID of the source AMI to use for the build."
  default     = "ami-0fe630eb857a6ec83"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC within which the build will occur."
  default     = "vpc-your-vpc"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet within which the build will occur."
  default     = "your-subnet"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to the resource."
  default = {
    "NAME"       = "packer-rhel9-aws"
    "OS_Version" = "RHEL"
    "Created-by" = "Packer"
  }

}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}



source "amazon-ebs" "rhel9" {
  profile       = var.profile
  source_ami    = var.source_ami
  vpc_id        = var.vpc_id
  subnet_id     = var.subnet_id
  region        = var.region
  instance_type = var.instance_type
  ssh_username  = var.ssh_username
  ami_name      = "${var.ami_prefix}-rhel-9-${local.timestamp}"
  tags          = var.tags

  source_ami_filter {
    filters = {
      "virtualization-type" = "hvm"
      "name"                = "${var.source_ami_name}"
      "root-device-type"    = "ebs"
    }
    owners      = [var.owners] # Red Hat's owner ID, adjust if using a different source
    most_recent = true
  }
}

build {
  sources = [
    "source.amazon-ebs.rhel9"
  ]



  provisioner "shell" {
    script = "basicsetup.sh"
  }


}
