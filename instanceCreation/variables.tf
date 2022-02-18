
variable "region" {
  description = "the AWS region in which resources are created, you must set the availability_zones variable as well if you define this value to something other than the default"
}

variable "key_name" {}

variable "vpc_security_group_ids" {}

variable "subnet_id" {}

variable "ec2_associate_public_ip_address" {}

variable "disable_api_termination" {}