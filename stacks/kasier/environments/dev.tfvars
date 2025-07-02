cidr_block           = "11.0.0.0/16"
Name                 = "dev-kaiser"
environment          = "kaiser/environment/dev/terraform.tfstate"
public_subnets_cidr  = ["11.0.32.0/20", "11.0.48.0/20"]
private_subnets_cidr = ["11.0.64.0/20", "11.0.80.0/20"]
