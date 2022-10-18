resource "aws_lb" "LB" {
  name               = "loadBalancer"
  internal           = false
  load_balancer_type = "application"
  # security_groups    = [aws_security_group.TerraformEc2Security.id]
  subnets            = [aws_subnet.publicSubnets["Public1"].id, aws_subnet.publicSubnets["Public2"].id]

  tags = {
    Name = "ujs"
  }
}

resource "aws_lb_target_group" "targetGroup" {
  name     = "targetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.mainVpc.id

  health_check {
    interval = "20"
    protocol = "HTTP"
    timeout = "2"
    path = "/"
    unhealthy_threshold = "2"
    healthy_threshold = "3"
  }
}