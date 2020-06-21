#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
variable ami_family {
    type = string
}

variable instance_size {
    type = "string"
    default = "t2.micro"
}

variable subnet_id {
    type = string
}

variable vpc_id {
    type = string
}

#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
variable ssh_securitygroup_id {
    type = "string"
}

variable ssh_keyname {
    type = "string"
}

#-------------------------------------------------------------------------------
# DNS
#-------------------------------------------------------------------------------
variable internal_dns_name {
    type = "string"
}
variable internal_dns_zone_id {
    type = "string"
}

variable external_dns_zone_id {
    type = "string"
}
variable external_dns_name {
    type = "string"
}
