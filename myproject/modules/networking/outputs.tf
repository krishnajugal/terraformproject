output "vpcid" {
  value = "${aws_vpc.myVpc.id}"
}
output "public_subnet_id" {
  value = "${aws_subnet.subnets[0].id}"
}
output "private_subnet_id" {
  value = "${aws_subnet.subnets[1].id}"
}
output "sg_id" {
  value = "${aws_security_group.ins-sg.id}"
}