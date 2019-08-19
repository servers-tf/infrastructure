variable "vpc_id" {
    type = "string"
}

variable "gameserver_subnet_id" {
    type = "string"
}

variable "ssh_securitygroup_id" {
    type = "string"
}

variable "ssh_keyname" {
    type = "string"
}

variable "gameserver_instance_size" {
    type = "string"
    default = "c5.large"
}

variable "gameserver_use_spot" {
    default = true
}
