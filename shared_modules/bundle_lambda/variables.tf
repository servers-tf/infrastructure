#-------------------------------------------------------------------------------
# Code
#-------------------------------------------------------------------------------
variable source_dir {
    description = "Directory relative to your tf file containing source code. Read README.md for more info."
    type = string
}
variable bucket {
    description = "S3 bucket to put the code"
    type = string
}
variable bucket_key_prefix {
    description = "Puts the code in this subfolder in the bucket"
    type = string
    default = "/"
}

#-------------------------------------------------------------------------------
# Lambda Fn
#-------------------------------------------------------------------------------
variable name {
    description = "Name of the Lambda function in AWS"
    type = string
}
variable description {
    type = string
    default = "Created by Terraform"
}
variable requirements {
    description = "A standard Python REQUIREMENTS.txt file relative to the source_dir"
    type = string
    default = "REQUIREMENTS.txt"
}
variable handler {
    description = "Must be `module.function`. Runs from the top level of the folder"
    type = string
    default = "main.handler"
}
variable runtime {
    description = "Python3.5 or later is supported by this module"
    type = string
    default = "python3.6"
}
variable memory_size {
    description = "Max memory in MB this function can use at runtime"
    type = number
    default = 128
}
variable timeout {
    description = "The amount of time in seconds this function has to complete"
    type = number
    default = 60
}
variable reserved_concurrent_executions {
    description = "How many runs can happen at one time. -1 is limitless"
    type = number
    default = -1
}
variable environment_variables {
    description = "Environment variables to pass to lambda function. See https://www.terraform.io/docs/providers/aws/r/lambda_function.html#environment"
    type = map
    default = null
}
variable vpc_config {
    description = "See https://www.terraform.io/docs/providers/aws/r/lambda_function.html#vpc_config"
    default = null
}
variable maximum_event_age_in_seconds {
    description = "After this many seconds waiting to start, don't start the lambda function"
    default = 60
}
variable maximum_retry_attempts {
    description = "The maximum number of times to retry the lambda function (0-2)"
    default = 0
}


#-------------------------------------------------------------------------------
# IAM
#-------------------------------------------------------------------------------
variable policies {
    description = "List of policy documents to attach to lambda function"
    type = list
    default = []
}

variable existing_policies {
    description = "List of existing policy arns to attach to lambda function"
    type = list
    default = []
}

#-------------------------------------------------------------------------------
# Logging
#-------------------------------------------------------------------------------
variable create_log_group {
    description = "Creates a log group in Cloudwatch for the lambda"
    type = bool
    default = true
}
variable log_retention {
    description = "Number of days to retain logs in Cloudwatch"
    type = number
    default = 30
}

#-------------------------------------------------------------------------------
# Triggers
#------------------------------------------------------------------------------
variable schedule_expression {
    description = "https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html"
    type = string
    default = null
}
variable event_pattern {
    description = "https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/CloudWatchEventsandEventPatterns.html"
    default = null
}
