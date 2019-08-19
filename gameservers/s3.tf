data "aws_caller_identity" "current" {}

data "template_file" "s3_public_policy" {
    template = "${file("${path.module}/policies/s3_public.json")}"
    vars = {
        bucket_name = "${data.aws_caller_identity.current.account_id}.maps"
    }
}

resource "aws_s3_bucket" "maps" {
    bucket = "${data.aws_caller_identity.current.account_id}.maps"
    acl = "public-read"

    policy = "${data.template_file.s3_public_policy.rendered}"
    
    website {
       index_document = "index.html"
       error_document = "error.html"
   }
}
