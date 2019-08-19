resource "aws_iam_instance_profile" "tf2_competitive" {
    name = "tf2_competitive"
    role = "${aws_iam_role.tf2_competitive.name}"
}

resource "aws_iam_role" "tf2_competitive" {
    name = "tf2_competitive"
    path = "/"
    assume_role_policy = file("${path.module}/policies/sts_assumerole.json")
}

resource "aws_iam_role_policy" "allow_ssm_getparams" {
    name = "allow_ssm_getparams"
    role = "${aws_iam_role.tf2_competitive.id}"

    policy = file("${path.module}/policies/ssm_getparameters.json")
}

resource "aws_iam_role_policy" "ec2_describe" {
    name = "ec2_describe"
    role = "${aws_iam_role.tf2_competitive.id}"

    policy = file("${path.module}/policies/ec2_describe.json")
}
