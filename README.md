# Terraform
This repo makes heavy use of [Hashicorp Terraform](https://www.terraform.io/). 

The state file for this repo is located in an S3 bucket.

### Required state
Before running this against an account to setup, you will need
* S3 bucket to keep the state file for Terraform
* An IAM user with valid credentials to set up everything

# Resources

This is a breif summary of the resources contained in this repo and why they exist.

## Network
Contains a basic VPC configuration

Includes an internal DNS zone
Default SSH security group to be used around other infrastructure
All the routes and network ACL's needed to make the rules below...

### Subnets
* Reserved - To be used by networking appliances if needs change.
* Sandbox - Used for things like Packer builds. No access to other subnets
* Web - Used for web sites and the Discord Bot
* Game Server - Used for all the game servers. This is made purposely large just in case
* Database - Used for databases. Not accessible to or from the internet. Game servers and Web can access this subnet privately


## Game Servers
Contains all the infrastructure peices for running the TF2 game servers

Includes:
* IAM policies for the EC2 instances
* An EC2 Launch Template, to make it easy for API's to launch these servers
* Security Groups for TF2
* An S3 bucket to store custom TF2 maps. This is a public static site

One limitation I can't get around is that the launch template seems to want to have a static image and has no ability to find the latest of a particular tag. It is up the API launching these instances to find that. Other than that, there should be no need for any other state.


## Automation
AWS accounts can be messy if you're not diligent about keeping it tidy. 

The automation in this module is basically to keep things tidy.

This will pickup changes made to the source code locally, and upload it to S3 and update the lambda functions accordingly.
This is very simliar in concept to [AWS SAM](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html), except without using Cloudformation Transforms.

Includes:
* Daily running lambda functions (easily configurble) that will clean up old AMI's. 
* More to come...
* IAM polcies


## Monitoring
This simply contains an ELK stack + Grafana

Includes:
* AWS Elastic Search / Kibana
* Launch Template for Grafana
* Security Groups for both
* IAM policies for both





