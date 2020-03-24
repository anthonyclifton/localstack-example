  provider "aws" {
    access_key                  = "mock_access_key"
    region                      = "us-east-1"
    s3_force_path_style         = true
    secret_key                  = "mock_secret_key"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true

    endpoints {
      apigateway     = "http://localhost:4567"
      kinesis        = "http://localhost:4568"
      dynamodb       = "http://localhost:4569"
      s3             = "http://localhost:4572"
      lambda         = "http://localhost:4574"
      sns            = "http://localhost:4575"
      sqs            = "http://localhost:4576"
      ses            = "http://localhost:4579"
      route53        = "http://localhost:4580"
      cloudwatch     = "http://localhost:4582"
      ssm            = "http://localhost:4583"
      sts            = "http://localhost:4592"
      iam            = "http://localhost:4593"
    }
  }