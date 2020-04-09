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

Setup
* Install VirtualBox
* Install Vagrant from here: https://www.vagrantup.com/downloads.html
* ./scripts/deploy-localstack.sh
* vagrant ssh (to manage the docker host)
* ./scripts/destroy-localstack.sh

Tutorial Resources
* [Localstack Docker Image](https://hub.docker.com/r/localstack/localstack)
* [Localstack Github Repo](https://github.com/localstack/localstack)
* [How to Fake AWS Locally with Localstack](https://dev.to/goodidea/how-to-fake-aws-locally-with-localstack-27me)
* [AWS CLI Local](https://github.com/localstack/awscli-local)
* [Connected to Local AWS Solutions](https://www.terraform.io/docs/providers/aws/guides/custom-service-endpoints.html#localstack)
* [Static Hosting with CDN](https://gist.github.com/nagelflorian/67060ffaf0e8c6016fa1050b6a4e767a)
* [Static Hosting with AWS S3](https://westerndevs.com/2018-10-12-cloudfront-terraform/)
* [Issue: Can't Do S3 Static Website in Localstack](https://github.com/localstack/localstack/issues/1734)
* [Terraform Provider for Localstack](https://gist.github.com/ozooxo/67d17b05dbb254997f4f4333efd3fc1d)
* [Getting Started with Vagrant](https://www.vagrantup.com/intro/getting-started/index.html)
* [Install Docker on Ubuntu 18.04 Bionic](https://phoenixnap.com/kb/how-to-install-docker-on-ubuntu-18-04)
* [Serverless Applications with AWS Lambda and API Gateway](https://learn.hashicorp.com/terraform/aws/lambda-api-gateway)
* [How to find REST API endpoints in Localstack](https://stackoverflow.com/questions/48236040/exactly-which-path-do-i-curl-for-localstack-api-gateway-lambda-integration)

http://localhost:4567/restapis
curl http://localhost:4567/restapis

awslocal apigateway get-resources --region us-east-1 --rest-api-id [rest-api-id]

curl http://localhost:4567/restapis/[rest-api-id]/hello/_user_request_/

awslocal dynamodb put-item --table-name Addresses --item '{"StreetAddress": {"S": "123"}, "City": {"S": "Test"}, "StateOrProvince": {"S": "Test2"}}'

awslocal dynamodb get-item --table-name Addresses --key '{"StateOrProvince": {"S": "Test2"}, "City": {"S": "Test"}}'