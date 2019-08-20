data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "template_file" "es_access_policy" {
    template = "${file("${path.module}/policies/es_access.json")}"
    vars = {
        name = "${var.elasticsearch_name}"
        region = "${data.aws_region.current.name}"
        account_id = "${data.aws_caller_identity.current.account_id}"
        domains = "${jsonencode(split(",", join(",", var.whitelist_ipaddrs)))}"
    }
}
