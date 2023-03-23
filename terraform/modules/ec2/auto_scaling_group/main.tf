resource "aws_launch_template" "app" {
  name_prefix               = "${var.application}_template"
  image_id                  = local.ami
  instance_type             = var.instance_type
  key_name                  = aws_key_pair.server_key.key_name
  user_data                 = filebase64("${path.root}/${var.user_data}")

  network_interfaces {
    subnet_id               = var.subnet_id
    security_groups         = "${var.security_groups}"
  }

  block_device_mappings {
    device_name             = "/dev/sdf"

    ebs {
      volume_size           = var.root_size
    }
  }

  lifecycle {
    create_before_destroy   = true
  }

}

resource "aws_autoscaling_group" "asg" {
  name                    = "${var.application}_asg"
  vpc_zone_identifier     = ["${var.subnet_id}"]
  min_size                = 1
  desired_capacity        = 1
  max_size                = 2

  launch_template {
    id                    = aws_launch_template.app.id
    version               = aws_launch_template.app.latest_version
  }

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                   = "Name"
    value                 = "${var.application}_server"
    propagate_at_launch   = true
  }
}