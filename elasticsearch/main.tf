resource "aws_elasticsearch_domain" "es" {
    domain_name = "${var.elasticsearch_name}"
    elasticsearch_version = "7.1"

    cluster_config {
        instance_type = "${var.elasticsearch_instance_size}"
        instance_count = "1"
        dedicated_master_enabled = false
        zone_awareness_enabled = false
    }

    access_policies = "${data.template_file.es_access_policy.rendered}"

    vpc_options {
        security_group_ids = ["${aws_security_group.es.id}"]
        subnet_ids = ["${var.web_subnet_id}"]
    }

    ebs_options {
        ebs_enabled = true
        volume_size = "${var.elasticsearch_disk_size}"
    }

    tags = {
        Domain = "${var.elasticsearch_name}"
    }
}
