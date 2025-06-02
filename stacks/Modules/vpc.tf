resource "aws_vpc" "vpc" {
   count = var.create_vpc ? 1 : 0   
   cidr_block = var.cidr
   instance_tenancy = var.tenancy
   enable_dns_hostnames = var.enable_dns_hostnames
   enable_dns_support   = var.enable_dns_support
  

   tags = {
     Name = var.Name
   }
  
}


