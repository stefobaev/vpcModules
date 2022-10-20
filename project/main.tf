provider "aws" {
    region = var.region
}

module "vpc" {
  source = "../modules/vpc"
}

module "alb" {
  source = "../modules/alb/"
  vpcId = module.vpc.vpcId
  publicSubnet = module.vpc.publicSubnet
}

module "clu" {
  source = "../modules/clu"
  vpcId = module.vpc.vpcId
  privateSubnet = module.vpc.privateSubnet
  iamRole = module.clu.iamRole
  listener = module.alb.listener
}