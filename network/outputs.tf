output "vpc_id" {
    value = aws_vpc.main.id
}

output "reserved_subnet_id" {
    value = aws_subnet.reserved.id
}

output "sandbox_subnet_id" {
    value = aws_subnet.sandbox.id
}

output "web_subnet_id" {
    value = aws_subnet.web.id
}

output "database_subnet_id" {
    value = aws_subnet.database.id
}

output "gameserver_subnet_id" {
    value = aws_subnet.gameserver.id
}

output "ssh_securitygroup_id" {
    value = aws_security_group.home_ssh.id
}

output "internal_dns_zone_id" {
    value = aws_route53_zone.private.id
}
