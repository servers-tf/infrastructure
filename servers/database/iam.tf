resource "aws_iam_instance_profile" "database" {
    name = "database"
    role = "${aws_iam_role.database.name}"
}

resource "aws_iam_role" "database" {
    name = "database"
    path = "/"
    assume_role_policy = file("${path.module}/policies/sts_assumerole.json")
}
