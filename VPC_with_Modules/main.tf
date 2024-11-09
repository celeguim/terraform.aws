
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "us_east_2"
  region = "us-east-2"
}

module "vpc1" {
  source  = "./vpc1"
  vpc_cidr             = var.vpc1_cidr
  public_subnet_cidrs  = var.vpc1_public_subnet_cidrs
  private_subnet_cidrs = var.vpc1_private_subnet_cidrs
}

module "vpc2" {
  source  = "./vpc2"
  vpc_cidr             = var.vpc2_cidr
  public_subnet_cidrs  = var.vpc2_public_subnet_cidrs
  private_subnet_cidrs = var.vpc2_private_subnet_cidrs
}
