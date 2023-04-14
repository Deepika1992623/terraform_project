terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

# launch templlate for instance

resource "aws_launch_template" "card-LT" {
  name = "card-app-LT"
  block_device_mappings {
    device_name = "/dev/sdf"
    ebs {
      volume_size = 6
    }
  }

  image_id = var.image_id
  instance_type = var.instance_type

  key_name = aws_key_pair.cardweb-keypair.id
  vpc_security_group_ids = [aws_security_group.allow_security_group.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "card-webapp"
    }
  }
  user_data = filebase64("project_download.sh")
}

# Auto scaling group

resource "aws_autoscaling_group" "card-ASG" {

  desired_capacity   = 2
  max_size           = 5
  min_size           = 2
  vpc_zone_identifier = [aws_subnet.card-subnet-1.id,aws_subnet.card-subnet-2.id]
  # if we restrict vpc_zone_identifier to our required subnet's the instances will be created in those subnet's
  target_group_arns = [aws_lb_target_group.webapp-TG.arn]

  launch_template {
    id      = aws_launch_template.card-LT.id
    version = "$Latest"
  }
}
