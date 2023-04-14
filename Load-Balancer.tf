#target group creation

resource "aws_lb_target_group" "webapp-TG" {
  name     = "webapp-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.card_vpc.id
}

# LB Listener

resource "aws_lb_listener" "webapp-listener" {
  load_balancer_arn = aws_lb.card-LB.arn
  port              = "80"
  protocol          = "HTTP"
 
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webapp-TG.arn
  }
}

#load balancer

resource "aws_lb" "card-LB" {
  name               = "card-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_security_group.id]
  subnets            = [aws_subnet.card-subnet-1.id,aws_subnet.card-subnet-2.id]

  tags = {
    Environment = "production"
  }
}