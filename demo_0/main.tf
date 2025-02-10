# ======================================================================================================================
# vpc
# ======================================================================================================================
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# ======================================================================================================================
# EC2 Instances
# ======================================================================================================================
resource "aws_instance" "demo_instances" {
  count           = var.instance-count
  ami             = "ami-05fa46471b02db0ce"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.demo0.name]
  key_name        = "my-instance-1-key"

  user_data = <<-EOF
        #!/bin/bash
        yum update -y
        yum install -y httpd
        systemctl start httpd
        systemctl enable httpd
        echo "Hello World from instance ${count.index}" > /var/www/html/index.html
    EOF
  tags = {
    Name = "instance-${count.index}"
  }
  depends_on = [aws_security_group.demo0]
}

# ======================================================================================================================
# Security Group
# ======================================================================================================================
resource "aws_security_group" "demo0" {

  tags = {
    Name = "demo0"
  }
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group" "demo0" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  tags = {
    Name = "demo0"
  }

  health_check {
    path     = "/"
    port     = 80
    protocol = "HTTP"
    interval = 30
    timeout  = 10
  }
}

resource "aws_lb_target_group_attachment" "demo0" {
  count            = length(aws_instance.demo_instances)
  target_group_arn = aws_lb_target_group.demo0.arn
  target_id        = aws_instance.demo_instances[count.index].id
}

resource "aws_lb" "demo0" {
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.demo0.id]
  subnets            = data.aws_subnets.default.ids

  tags = {
    Name = "demo0"
  }
}

resource "aws_lb_listener" "demo0" {
  load_balancer_arn = aws_lb.demo0.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.demo0.arn
  }

  tags = {
    Name = "demo0"
  }
}