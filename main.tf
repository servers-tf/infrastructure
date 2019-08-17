provider "aws" {
    region = "us-east-2"
}

terraform {
    backend "s3" {
        bucket = "660714711582.terraform"
        key = "terraform.tfstate"
        region = "us-east-2"
    }
}
