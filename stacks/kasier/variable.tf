variable "cidr_block" {
  default = "11.0.0.0/16"

}

variable "tenancy" {
  default = "default"

}

variable "Name" {
    default = "Kaiser"
  
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


variable "Env" {
  default = "dev"

}
