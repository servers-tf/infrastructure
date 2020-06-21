data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "lambdas" {
    bucket = "${data.aws_caller_identity.current.account_id}.lambdas"
    acl = "private"
}

module "clean_amis-tf2-competitive" {
    source = "../../shared_modules/bundle_lambda"

    source_dir = "${path.module}/src"
    name = "clean_amis-tf2-competitive"
    bucket = aws_s3_bucket.lambdas.id
    handler = "clean_amis.handler"

    schedule_expression = "rate(1 day)"

    policies = [
        file("${path.module}/policies/lambda_deleteamis.json")
    ]

    environment_variables = {
        keep = "3"
        family = "tf2-competitive"
    }
}

module "clean_amis-grafana" {
    source = "../../shared_modules/bundle_lambda"

    source_dir = "${path.module}/src"
    name = "clean_amis-grafana"
    bucket = aws_s3_bucket.lambdas.id
    handler = "clean_amis.handler"

    schedule_expression = "rate(1 day)"

    policies = [
        file("${path.module}/policies/lambda_deleteamis.json")
    ]

    environment_variables = {
        keep = "1"
        family = "grafana"
    }
}

module "clean_amis-database" {
    source = "../../shared_modules/bundle_lambda"

    source_dir = "${path.module}/src"
    name = "clean_amis-database"
    bucket = aws_s3_bucket.lambdas.id
    handler = "clean_amis.handler"

    schedule_expression = "rate(1 day)"

    policies = [
        file("${path.module}/policies/lambda_deleteamis.json")
    ]

    environment_variables = {
        keep = "1"
        family = "database"
    }
}

module "clean_amis-base" {
    source = "../../shared_modules/bundle_lambda"

    source_dir = "${path.module}/src"
    name = "clean_amis-base"
    bucket = aws_s3_bucket.lambdas.id
    handler = "clean_amis.handler"

    schedule_expression = "rate(1 day)"

    policies = [
        file("${path.module}/policies/lambda_deleteamis.json")
    ]

    environment_variables = {
        keep = "1"
        family = "base"
    }
}
