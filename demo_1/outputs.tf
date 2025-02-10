output "public-subnets" {
  value = aws_subnet.demo1_public
}

output "private-subnets" {
  value = aws_subnet.demo1_private
}

output "default-vpc-route-table" {
  value = aws_vpc.demo1.default_route_table_id
}

