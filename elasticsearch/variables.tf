variable "vpc_id" {
    type = "string"
}

variable "web_subnet_id" {
    type = "string"
}

variable "elasticsearch_name" {
    type = "string"
}

variable "elasticsearch_instance_size" {
    type = "string"
}

variable "elasticsearch_disk_size" {
    type = "string"
}

variable "internal_dns_zone_id" {
    type = "string"
}

variable "whitelist_ipaddrs" {
    type = "list"
}
