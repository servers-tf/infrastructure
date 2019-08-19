variable "clean_amis" {
    type = "list"
    default = [
        {keep = "1", family = "base"}
    ]
}

resource "aws_iam_role" "clean_amis" {
    name = "iam_for_lambda"
    path = "/"
    assume_role_policy = file("${path.module}/policies/sts_assumerole.json")
}

resource "aws_iam_role_policy" "allow_image_delete" {
    name = "allow_image_delete"
    role = "${aws_iam_role.clean_amis.id}"

    policy = file("${path.module}/policies/lambda_deleteamis.json")
}

resource "aws_s3_bucket_object" "clean_amis_code" {
    bucket = "${aws_s3_bucket.lambdas.id}"
    key = "clean_amis.zip"
    source = "${path.module}/clean_amis.zip"

    etag = "${filemd5("${path.module}/clean_amis.zip")}"
}

resource "aws_lambda_function" "clean_amis" {
    count = "${length(var.clean_amis)}"
    
    function_name = "clean_amis-${var.clean_amis[count.index].family}"

    s3_bucket = "${aws_s3_bucket.lambdas.id}"
    s3_key = "${aws_s3_bucket_object.clean_amis_code.id}"

    role = "${aws_iam_role.clean_amis.arn}"
    handler = "clean_amis.handler"

    publish = true
    source_code_hash = "${filebase64sha256("${path.module}/clean_amis.zip")}"

    runtime = "python3.6"

    environment {
        variables = {
            keep = "${var.clean_amis[count.index].keep}"
            family = "${var.clean_amis[count.index].family}"
        }
    }
}

resource "aws_cloudwatch_event_rule" "run_daily" {
    name = "run_daily"
    schedule_expression = "rate(1 day)"
}

resource "aws_cloudwatch_event_target" "sns" {
    count = "${length(var.clean_amis)}"
    
    rule = "${aws_cloudwatch_event_rule.run_daily.name}"
    arn = "${aws_lambda_function.clean_amis[count.index].arn}"
}
