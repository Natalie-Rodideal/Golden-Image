ami_prefix      = "packer-rhel9-image"
region          = "us-east-1"
source_ami      = "ami-0fe630eb857a6ec83"
profile         = "shared-services"
vpc_id          = "vpc-0176e5a84b0d1f93f"
subnet_id       = "subnet-00d28f0a25745d2e4"
ssh_username    = "ec2-user"
instance_type   = "t2.micro"
source_ami_name = "RHEL-9*"
owners          = "309956199498"

tags = {
  NAME       = "custom-rhel9-aws"
  OS_Version = "RHEL"
  Created-by = "Packer"
}
