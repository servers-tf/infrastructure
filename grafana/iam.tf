resource "aws_iam_instance_profile" "grafana" {
    name = "grafana"
    role = "${aws_iam_role.grafana.name}"
}

resource "aws_iam_role" "grafana" {
    name = "grafana"
    path = "/"
    assume_role_policy = file("${path.module}/policies/sts_assumerole.json")
}
