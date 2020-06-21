#-------------------------------------------------------------------------------
# IAM
#-------------------------------------------------------------------------------
resource "aws_iam_role" "lambda_execution" {
    name = "${var.name}_execution_role"
    path = "/lambda/"
    assume_role_policy = file("${path.module}/policies/sts_assumerole.json")
}

resource "aws_iam_role_policy" "extra_policies" {
    # Attach additional policy documents
    count = length(var.policies)
    role = aws_iam_role.lambda_execution.id
    policy = var.policies[count.index]
}

resource "aws_iam_role_policy_attachment" "extra_managed_policies" {
    # Attach existing policies
    count = length(var.existing_policies)
    role = aws_iam_role.lambda_execution.id
    policy_arn = var.existing_policies[count.index]
}

#-------------------------------------------------------------------------------
# CloudWatch Logs
#-------------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "this" {
    count = var.create_log_group ? 1 : 0
    name = "/aws/lambda/${aws_lambda_function.this.function_name}"
    retention_in_days = var.log_retention
}

resource "aws_iam_role_policy_attachment" "cloudwatch_log_policy" {
    # Attach built-in lambda cloudwatch policy to push to logs
    count = var.create_log_group ? 1 : 0
    role = aws_iam_role.lambda_execution.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

#-------------------------------------------------------------------------------
# Code zip'd into S3
#-------------------------------------------------------------------------------
resource "null_resource" "build" {
    triggers = {
        always_run = timestamp()
    }

    provisioner "local-exec" {
        command = join(" ", [
            "/bin/bash",
            "${path.module}/build.sh",
            "${var.source_dir}",
            "${var.requirements}" ,
            "/tmp/${var.name}.zip"
        ])
    }
}

# Forces build to be run before we upload to S3
data "null_data_source" "build_dep" {
    inputs = {
        build_id = null_resource.build.id
        archive = "/tmp/${var.name}.zip"
    }
}

resource "aws_s3_bucket_object" "code_archive" {
    bucket = var.bucket
    key = "${var.name}.zip"
    source = data.null_data_source.build_dep.outputs.archive
    etag = fileexists(data.null_data_source.build_dep.outputs.archive) ? filemd5(data.null_data_source.build_dep.outputs.archive) : md5(timestamp())

    # Make it so the object will be updated instead of deleted and replaced
    lifecycle {
        create_before_destroy = true
    }
}

#-------------------------------------------------------------------------------
# Trigger
#-------------------------------------------------------------------------------
resource "aws_cloudwatch_event_rule" "trigger_rule" {
    name = var.name
    schedule_expression = var.schedule_expression
    event_pattern = var.event_pattern
}

resource "aws_cloudwatch_event_target" "trigger_target" {
    rule = aws_cloudwatch_event_rule.trigger_rule.name
    arn = aws_lambda_function.this.arn
}

# Allow Cloudwatch event to invoke this function
resource "aws_lambda_permission" "allow_cloudwatch" {
    function_name = aws_lambda_function.this.function_name
    source_arn = aws_cloudwatch_event_rule.trigger_rule.arn
    principal = "events.amazonaws.com"
    action = "lambda:InvokeFunction"
}

#-------------------------------------------------------------------------------
# Lambda function
#-------------------------------------------------------------------------------
resource "aws_lambda_function" "this" {
    # Metadata
    function_name = var.name
    description = var.description
    publish = true

    # Configuration
    handler = var.handler
    runtime = var.runtime
    timeout = var.timeout
    memory_size = var.memory_size
    reserved_concurrent_executions = var.reserved_concurrent_executions

    # Code
    s3_bucket = var.bucket
    s3_key = aws_s3_bucket_object.code_archive.id
    source_code_hash = aws_s3_bucket_object.code_archive.id

    # IAM
    role = aws_iam_role.lambda_execution.arn

    # Dynamic blocks passthrough
    dynamic "environment" {
        for_each = var.environment_variables == null ? [] : [var.environment_variables]
        content {
            variables = environment.value
        }
    }

    dynamic "vpc_config" {
        for_each = var.vpc_config == null ? [] : [var.vpc_config]
        content {
            security_group_ids = vpc_config.value.security_group_ids
            subnet_ids = vpc_config.value.subnet_ids
        }
    }
}
