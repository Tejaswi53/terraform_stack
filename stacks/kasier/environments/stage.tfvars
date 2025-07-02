cidr_block           = "13.0.0.0/16"
Name                 = "stage-kaiser"
environment          = "kaiser/environment/stage/terraform.tfstate"
public_subnets_cidr  = ["13.0.32.0/20", "13.0.48.0/20"]
private_subnets_cidr = ["13.0.64.0/20", "13.0.80.0/20"]
