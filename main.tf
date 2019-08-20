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
    
    ssh_ip_addrs = ["99.31.76.144/32"]
    
    reserved_subnet_cidr = "10.0.0.0/24"
    sandbox_subnet_cidr = "10.0.1.0/24"
    web_subnet_cidr = "10.0.2.0/24"
    database_subnet_cidr = "10.0.3.0/24"
    gameserver_subnet_cidr = "10.0.4.0/22"
}

module "gameservers" {
    source = "./gameservers"

    vpc_id = module.network.vpc_id
    ssh_securitygroup_id = module.network.ssh_securitygroup_id
    ssh_keyname = "backdoor"

    gameserver_subnet_id = module.network.gameserver_subnet_id
    gameserver_instance_size = "c5.large"
    gameserver_use_spot = true
}

module "automation" {
    source = "./automation"
    
    clean_amis = [
        {keep = "3", family = "tf2-competitive"},
        {keep = "1", family = "grafana"},
        {keep = "1", family = "base"}
    ]
}

module "elasticsearch" {
    source = "./elasticsearch"
    
    vpc_id = module.network.vpc_id
    web_subnet_id = module.network.database_subnet_id

    elasticsearch_name = "elasticsearch"
    elasticsearch_instance_size = "t2.small.elasticsearch"
    elasticsearch_disk_size = "10"
    internal_dns_zone_id = module.network.internal_dns_zone_id
    
    whitelist_ipaddrs = ["99.31.76.144/32"]
}

module "grafana" {
    source = "./grafana"
    
    vpc_id = module.network.vpc_id
    ssh_securitygroup_id = module.network.ssh_securitygroup_id
    ssh_keyname = "backdoor"

    grafana_subnet_id = module.network.web_subnet_id
    grafana_instance_size = "t2.micro"
    external_dns_zone_id = "Z3AGAJ48ZCJ4VC"
    
    whitelist_ipaddrs = ["99.31.76.144/32"]
}
