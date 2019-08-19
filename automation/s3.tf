data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "lambdas" {
    bucket = "${data.aws_caller_identity.current.account_id}.lambdas"
    acl = "private"
}
