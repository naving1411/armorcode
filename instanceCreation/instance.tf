data "aws_imagebuilder_image" "ubuntu" {
  arn = "arn:aws:imagebuilder:ap-south-1:991667272586:image/amibuilder-recipe-ubuntu/1.0.0"
}

data "aws_ami" "imageBuilder_ubuntu" {
  most_recent      = true
  owners           = ["self"]

  tags = {
    Ec2ImageBuilderArn  = data.aws_imagebuilder_image.ubuntu.id
  }
}

resource "aws_instance" "main" {

  ami                         = data.aws_ami.imageBuilder_ubuntu.id
  instance_type               = "t3a.micro"
  key_name                    = "${var.key_name}"
  vpc_security_group_ids      = [var.vpc_security_group_ids]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = "${var.ec2_associate_public_ip_address}"
  disable_api_termination     = "${var.disable_api_termination}"

  lifecycle {
    create_before_destroy = true
  }
}