data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "maps" {
    bucket = "${data.aws_caller_identity.current.account_id}.maps"
    acl = "private"
}
