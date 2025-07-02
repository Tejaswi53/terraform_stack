cidr_block           = "12.0.0.0/16"
Name                 = "prod-kaiser"
environment          = "kaiser/environment/prod/terraform.tfstate"
public_subnets_cidr  = ["12.0.32.0/20", "12.0.48.0/20"]
private_subnets_cidr = ["12.0.64.0/20", "12.0.80.0/20"]
