variable "vpc_id" {
    type = string
}

variable "subnet_id" {
    type = string
}

variable "security_group_ids" {
    type = list
    default = []
}

variable "ssh_keyname" {
    type = string
}

variable "instance_size" {
    type = string
    default = "c5.large"
}

variable "use_spot" {
    default = true
}
