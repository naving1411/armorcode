# --------------------------------------------
# GLOBAL VARIABLES
name = "NavinTest"

## user parameter not yet used, it is just to specify that the infra is create by terraform
user = "terraform"

# aws_profile = ""
environment = "UAT"   # TODO: Environment is Production on EC2 instances
tag_environment = "UAT"
tag_businessowner = "navin"
tag_businessdepartment = "Technology"

region = "ap-south-1"
terraform_s3_bucket = "navin-terraform-state"
aws_account_id = "991667272586"
# --------------------------------------------
# VPC and SUBNET VARIABLES
cidr = "172.24.0.0/16"
public_subnets_block_1 = ["172.24.1.0/24|ap-south-1a|App1","172.24.3.0/24|ap-south-1b|App2"]
private_subnets_block_1 = ["172.24.0.0/24|ap-south-1a|App1","172.24.2.0/24|ap-south-1b|App2","172.24.4.0/24|ap-south-1a|DB1","172.24.6.0/24|ap-south-1b|DB2"]
nat_az_and_subnet_name = "ap-south-1a|App1"

## This is a pre-created Elastic IP for NAT gateway since we don't want to change nat gateway IP in case we want to destroy the system and spin up again for weekends/holidays.

# --------------------------------------------
# LOAD BALANCER VARIABLES

# navin prod core api server ami - ami-05c5811fc920f3e2b
aws_amis = {
  "nginx" = "ami-08014726ef33785e5", ### Add AWS marketplace AMI for ubuntu here
  "multiapp" = "ami-0a5167eaa96fc0bf4",
  "db_server" = "ami-0584625dbad61483b", ### Add AMI ID from mysql machine here
}

key_name = "navin-aws_ap_south_1"

vpc_security_group_ids = "sg-0e59e7b7625408d85"

subnet_id = "subnet-07f71d17a033c1f67"

ec2_associate_public_ip_address = false

disable_api_termination = false