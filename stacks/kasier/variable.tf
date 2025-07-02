variable "cidr_block" {
  default = "11.0.0.0/16"
}

variable "tenancy" {
  default = "default"
}

variable "Name" {
  default = "jpmrg"
}

variable "region" {
  default = "us-east-1"
}

variable "create_vpc" {
  type    = bool
  default = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true

}

variable "enable_dns_support" {
  type    = bool
  default = true
}


variable "environment" {
  default = "kaiser/terraform.tfstate"
}

variable "public_subnets_cidr" {
  type    = list(string)
  default = ["11.0.1.0/24", "11.0.2.0/24"]
}

variable "private_subnets_cidr" {
  type    = list(string)
  default = ["11.0.3.0/24", "11.0.4.0/24"]
}
