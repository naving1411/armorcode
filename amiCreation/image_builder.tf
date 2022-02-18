resource "aws_imagebuilder_image_pipeline" "this" {
  image_recipe_arn                 = aws_imagebuilder_image_recipe.this.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.this.arn
  name                             = "amiBuilder-pipeline-ubuntu"
  status                           = "ENABLED"
  description                      = "Creates an ubuntu image."
  tags = {
    "Name" = "Test-AMI"
  }
}

##EC2 Image Builder Recipe
##In the Image Recipe, I’m defining the AMI’s volume size and type, and the components. For this simple example, ##I’m only installing the CloudWatch agent to the AMI.


resource "aws_imagebuilder_image" "this" {
  #distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.this.arn
  image_recipe_arn                 = aws_imagebuilder_image_recipe.this.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.this.arn
  enhanced_image_metadata_enabled  = false

  image_tests_configuration {
    image_tests_enabled = false
    timeout_minutes     = 60
  }
}

resource "aws_imagebuilder_image_recipe" "this" {
  block_device_mapping {
    device_name = "/dev/xvdb"

    ebs {
      delete_on_termination = true
      volume_size           = 25
      volume_type           = "gp3"
    }
  }

  component {
    component_arn = "arn:aws:imagebuilder:ap-south-1:991667272586:component/amibuilder-component-ubuntu/1.0.0/1"
  }

  name         = "amiBuilder-recipe-ubuntu"
  parent_image = "arn:aws:imagebuilder:ap-south-1:aws:image/ubuntu-server-20-lts-x86/x.x.x"
  version      = "1.0.0"
}

##Select the EC2 instance type, the IAM role, security group, subnet, logging bucket, and much more in the ##infrastructure configuration resource.

resource "aws_imagebuilder_infrastructure_configuration" "this" {
  description           = "Simple infrastructure configuration"
  instance_profile_name = "imageBuilder-Role"
  instance_types        = ["t3a.micro"]
  key_pair              = var.key_name
  name                  = "amiBuilder_infra_configuration_ubuntu"
  security_group_ids    = [var.vpc_security_group_ids]

  subnet_id                     = "subnet-07f71d17a033c1f67"
  terminate_instance_on_failure = true

  logging {
    s3_logs {
      s3_bucket_name = "navin-cloudwatch-agent"
      s3_key_prefix  = "image-builder"
    }
  }

  tags = {
    Name = "amiBuilder_infra_configuration_ubuntu"
  }
}


##EC2 Image Builder Distribution Configuration
##Here you can choose to share this AMI with other accounts or it’s just for this account. You can tag the AMI in 
##this resource too.


resource "aws_imagebuilder_distribution_configuration" "this" {
  name = "ami-builder-distribution-ubuntu"

  distribution {
    ami_distribution_configuration {
      name = "ubuntu-{{ imagebuilder:buildDate }}"

      launch_permission {
        user_ids = ["991667272586"]
      }
    }
    region = "ap-south-1"
  }
}