variable "vpca" {
  default = "10.10.0.0/16"
}

variable "private_vpca_subnets_cidr" {
  default = ["10.10.0.0/20", "10.10.16.0/20", "10.10.32.0/20", "10.10.48.0/20"]
}

variable "public_vpca_subnets_cidr" {
  default = ["10.10.64.0/20", "10.10.80.0/20", "10.10.96.0/20", "10.10.112.0/20"]
}

variable "database_vpca_subnets_cidr" {
  default = ["10.10.128.0/20", "10.10.144.0/20", "10.10.160.0/20", "10.10.176.0/20"]
}

variable "vpcb" {
  default = "10.20.0.0/16"
}

variable "private_vpcb_subnets_cidr" {
  default = ["10.20.0.0/20", "10.20.16.0/20", "10.20.32.0/20", "10.20.48.0/20"]
}

variable "public_vpcb_subnets_cidr" {
  default = ["10.20.64.0/20", "10.20.80.0/20", "10.20.96.0/20", "10.20.112.0/20"]
}

variable "database_vpcb_subnets_cidr" {
  default = ["10.20.128.0/20", "10.20.144.0/20", "10.20.160.0/20", "10.20.176.0/20"]
}

variable "vpcc" {
  default = "10.30.0.0/16"
}

variable "private_vpcc_subnets_cidr" {
  default = ["10.30.0.0/20", "10.30.16.0/20", "10.30.32.0/20", "10.30.48.0/20"]
}

variable "public_vpcc_subnets_cidr" {
  default = ["10.30.64.0/20", "10.30.80.0/20", "10.30.96.0/20", "10.30.112.0/20"]
}

variable "database_vpcc_subnets_cidr" {
  default = ["10.30.128.0/20", "10.30.144.0/20", "10.30.160.0/20", "10.30.176.0/20"]
}