resource "aws_alb" "default" {
  name            = "alb-propesq"
  security_groups = [aws_security_group.alb.id, aws_security_group.alb-2.id]

  subnets = [
    aws_subnet.public__a.id,
    aws_subnet.public__b.id
  ]
}

resource "aws_alb_target_group" "prod_propesq" {
  health_check {
    path = "/robots.txt"
  }

  name     = "alb-target-group-prod-propesq"
  port     = 80
  protocol = "HTTP"

  stickiness {
    type = "lb_cookie"
  }

  vpc_id = aws_vpc.vpc.id
}

resource "aws_alb_listener" "prod_propesq" {
  default_action {
    target_group_arn = aws_alb_target_group.prod_propesq.arn
    type             = "forward"
  }

  load_balancer_arn = aws_alb.default.arn
  port              = 80
  protocol          = "HTTP"
}

resource "aws_alb_target_group" "prod_geoserver" {
  health_check {
    path = "/"
  }

  name     = "alb-target-group-prod-geoserver"
  port     = 8080
  protocol = "HTTP"

  stickiness {
    type = "lb_cookie"
  }

  vpc_id = aws_vpc.vpc.id
}

resource "aws_alb_listener" "prod_geoserver" {
  default_action {
    target_group_arn = aws_alb_target_group.prod_geoserver.arn
    type             = "forward"
  }

  load_balancer_arn = aws_alb.default.arn
  port              = 8080
  protocol          = "HTTP"
}

resource "aws_security_group" "alb" {
  description = "security-group--alb"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8080
    protocol    = "tcp"
    to_port     = 8080
  }

  name = "security-group--alb"

  tags = {
    Env  = "production"
    Name = "security-group--alb"
  }

  vpc_id = aws_vpc.vpc.id
}
resource "aws_security_group" "alb-2" {
  description = "security-group--alb-2"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8080
    protocol    = "tcp"
    to_port     = 8080
  }

  name = "security-group--alb-2"

  tags = {
    Env  = "production"
    Name = "security-group--alb-2"
  }

  vpc_id = aws_vpc.vpc.id
}