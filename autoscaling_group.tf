# Criando auto scaling group
/*resource "aws_autoscaling_group" "ASG-WP" {
  name = "ASG WP"
  desired_capacity = 2
  max_size = 4
  min_size = 1
  force_delete = true
  depends_on = [ aws_lb.ALB-tf ]
  target_group_arns = ["${aws_lb_target_group.TG-tf.arn}"]
  health_check_type = "EC2"
  launch_configuration = aws_launch_configuration.webserver-launch-config.Name
  vpc_zone_identifier = ["${aws_subnet.this.id}", "${aws_subnet.this.id}"]
}*/
