# Full Stack Example Using Terraform and AWS Localstack

## Why?

Because it would be nice to be able to fully smoke test applications deployed to AWS locally or in CI, at little or no cost.

## What?

Boilerplate with the following AWS services supported by the community edition of Localstack, deployed by Terraform.

* API Gateway
* DynamoDB
* S3
* Lambda
* SQS
* SES
* Route53
* Cloudwatch
* SSM
* IAM
* EC2 (maybe)
* KMS

## How?

* Install VirtualBox
* Install Vagrant from here: https://www.vagrantup.com/downloads.html
* vagrant init hashicorp/bionic64 (the first time to create Vagrantfile)
* vagrant up
* vagrant ssh
* vagrant destroy
