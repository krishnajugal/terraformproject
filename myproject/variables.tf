variable "regionname" {}
variable "cidrblock" {}
variable "subnet_cidrblock" {
  type = "list"
}
variable "subnetnames" {
  type = "list"
}
variable "amiid" {}
variable "machinetype" {}
variable "alltraffic" {}
variable "keyname" {}
variable "keypair" {}