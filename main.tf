provider "aws" {
    region = "us-east-2"
}

terraform {
    backend "s3" {
        bucket = "660714711582.terraform"
        key = "terraform.tfstate"
        region = "us-east-2"
    }
}

module "network" {
    source = "./network"
    
    vpc_cidr = "10.0.0.0/16"
    internal_domain = "stf.internal"
    dns_resolvers = ["10.0.0.2", "8.8.8.8"]
    
    reserved_subnet_cidr = "10.0.0.0/24"
    sandbox_subnet_cidr = "10.0.1.0/24"
    web_subnet_cidr = "10.0.2.0/24"
    database_subnet_cidr = "10.0.3.0/24"
    gameserver_subnet_cidr = "10.0.4.0/22"
}
