#
# resource "aws_instance" "demo_custom_ami_ins1" {
#
#   ami             = "ami-05fa46471b02db0ce"
#   instance_type   = "t2.micro"
#   security_groups = ["launch-wizard-1"]
#   key_name        = "my-instance-1-key"
#   user_data       = <<-EOF
#         #!/bin/bash
#         yum update -y
#         yum install -y httpd
#         systemctl start httpd
#         systemctl enable httpd
#         echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.htm
#     EOF
#
#   tags = {
#     Name = "demo_custom_ami_ins1"
#   }
# }