output "elb" {
  value = aws_elb.alb.name
}

output "instance_sec_group" {
  value = aws_security_group.instance_sg.id
}
