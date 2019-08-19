variable "vpc_cidr" {
    type = "string"
    default = "10.0.0.0/16"
}

variable "internal_domain" {
    type = "string"
    default = "internal"
}

variable "dns_resolvers" {
    type = "list"
    default = ["10.0.0.2", "8.8.8.8"]
}

variable "ssh_ip_addrs" {
    type = "list"
    default = ["0.0.0.0/0"]
}

variable "reserved_subnet_cidr" {
    type = "string"
    default = "10.0.0.0/24"
}

variable "sandbox_subnet_cidr" {
    type = "string"
    default = "10.0.1.0/24"
}

variable "web_subnet_cidr" {
    type = "string"
    default = "10.0.2.0/24"
}
    
variable "database_subnet_cidr" {
    type = "string"
    default = "10.0.3.0/24"
}

variable "gameserver_subnet_cidr" {
    type = "string"
    default = "10.0.4.0/22"
}
