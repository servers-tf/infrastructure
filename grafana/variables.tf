variable "vpc_id" {
    type = "string"
}

variable "ssh_securitygroup_id" {
    type = "string"
}

variable "ssh_keyname" {
    type = "string"
}

variable "grafana_instance_size" {
    type = "string"
    default = "t2.micro"
}

variable "grafana_subnet_id" {
    type = "string"
    default = "t2.micro"
}

variable "external_dns_zone_id" {
    type = "string"
    default = "t2.micro"
}

variable "whitelist_ipaddrs" {
    type = "list"
}
