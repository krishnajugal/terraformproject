terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "terraformdemojugal"
    workspaces {
      name = "dev"
    }
  }
}
provider "aws" {
  region = var.regionname
}
module "networking" {
  source = "./modules/networking"
  cidrblock = var.cidrblock
  subnet_cidrblock = var.subnet_cidrblock
  subnetnames = var.subnetnames
  alltraffic = var.alltraffic
}
module "compute" {
  source = "./modules/compute"
  amiid = var.amiid
  machinetype = var.machinetype
  public_subnet_id = "${module.networking.public_subnet_id}"
  alltraffic = var.alltraffic
  keyname = var.keyname
  keypair = var.keypair
  sg_id  = "${module.networking.sg_id}"
}