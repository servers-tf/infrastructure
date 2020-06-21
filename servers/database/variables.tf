variable "vpc_id" {
    type = "string"
}

variable "ssh_securitygroup_id" {
    type = "string"
}

variable "ssh_keyname" {
    type = "string"
}

variable "database_instance_size" {
    type = "string"
    default = "t2.micro"
}

variable "database_subnet_id" {
    type = "string"
}

variable "internal_dns_zone_id" {
    type = "string"
}
