output "sec_group_id" {
	value = aws_security_group.tf-sg.id
}

output "pub_sub_a_id" {
	value = aws_subnet.pub-sub-a.id
}

output "pub_sub_b_id" {
	value = aws_subnet.pub-sub-b.id
}

output "priv_sub_a_id" {
	value = aws_subnet.priv-sub-a.id
}

output "priv_sub_b_id" {
	value = aws_subnet.priv-sub-b.id
}
