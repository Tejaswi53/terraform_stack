variable "cidr" {
  default = "10.0.1.0/16"
}

variable "Name" {
  default = "kaiser"
}

variable "tenancy" {
  default = "default"
}

variable "create_vpc" {
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "key" {
  type    = string
  default = ""
}

variable "public_subnets_cidr" {
  default = ["10.0.32.0/20", "10.0.48.0/20"]
}
