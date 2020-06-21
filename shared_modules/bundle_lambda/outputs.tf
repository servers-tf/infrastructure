output "lambda_function" {
    value = aws_lambda_function.this
}

output "iam_role" {
    value = aws_iam_role.lambda_execution
}

output "bucket_object" {
    value = aws_s3_bucket_object.code_archive
}

output "log_group" {
    value = var.create_log_group  ? aws_cloudwatch_log_group.this : null
}
