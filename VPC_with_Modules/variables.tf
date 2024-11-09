variable "vpc1_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc2_cidr" {
  default = "10.1.0.0/16"
}

variable "vpc1_public_subnet_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc1_private_subnet_cidrs" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "vpc2_public_subnet_cidrs" {
  default = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "vpc2_private_subnet_cidrs" {
  default = ["10.1.3.0/24", "10.1.4.0/24"]
}
