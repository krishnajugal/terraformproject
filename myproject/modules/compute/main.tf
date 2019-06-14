resource "aws_key_pair" "myEc2KeyPair" {
  key_name = var.keyname
  public_key = var.keypair
}
resource "aws_instance" "ins-1" {
  ami = var.amiid
  instance_type = var.machinetype
  associate_public_ip_address = true
  subnet_id = var.public_subnet_id
  security_groups = [var.sg_id]
  key_name = "${aws_key_pair.myEc2KeyPair.key_name}"
  user_data = "${file("./modules/compute/userdata.sh")}"
}
resource "aws_instance" "ins-2" {
  ami = var.amiid
  instance_type = var.machinetype
  associate_public_ip_address = true
  subnet_id = var.public_subnet_id
  security_groups = [var.sg_id]
  key_name = "${aws_key_pair.myEc2KeyPair.key_name}"
  user_data = "${file("./modules/compute/userdata.sh")}"

}
