resource "aws_elasticsearch_domain" "es" {
    domain_name = "gameservers"
    elasticsearch_version = "6.3"

    cluster_config {
        instance_type = "t2.micro.elasticsearch"
    }

    vpc_options {
        subnet_ids = [
            "${aws_subnet.web.id}"
        ]

        security_group_ids = ["${aws_security_group.es.id}"]
    }

    advanced_options = {
        "rest.action.multi.allow_explicit_index" = "true"
    }

    access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/gameservers/*"
        }
    ]
}
CONFIG

    depends_on = [
        "aws_iam_service_linked_role.es",
    ]
}

resource "aws_security_group" "es" {
    name = "elasticsearch-gameservers"
    vpc_id = "${aws_vpc.main.id}"

    ingress {
        from_port = 443
        to_port   = 443
        protocol  = "tcp"

        cidr_blocks = [
            "10.0.0.0/16",
            "99.31.76.144/32"
        ]
    }
}

resource "aws_iam_service_linked_role" "es" {
    aws_service_name = "es.amazonaws.com"
}
