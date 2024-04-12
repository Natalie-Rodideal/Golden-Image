ami_prefix      = "packer-rhel9-image"
region          = "us-east-1"
source_ami      = "ami-0fe630eb857a6ec83"
profile         = ""
vpc_id          = ""
subnet_id       = ""
ssh_username    = "ec2-user"
instance_type   = "t2.micro"
source_ami_name = "RHEL-9*"
owners          = "309956199498"

tags = {
  NAME       = "custom-rhel9-aws"
  OS_Version = "RHEL"
  Created-by = "Packer"
}
