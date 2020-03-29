  provider "aws" {
    access_key                  = "mock_access_key"
    region                      = "us-east-1"
    s3_force_path_style         = true
    secret_key                  = "mock_secret_key"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true

    endpoints {
      apigateway     = "http://192.168.0.7:4567"
      kinesis        = "http://192.168.0.7:4568"
      dynamodb       = "http://192.168.0.7:4569"
      s3             = "http://192.168.0.7:4572"
      lambda         = "http://192.168.0.7:4574"
      sns            = "http://192.168.0.7:4575"
      sqs            = "http://192.168.0.7:4576"
      ses            = "http://192.168.0.7:4579"
      route53        = "http://192.168.0.7:4580"
      cloudwatch     = "http://192.168.0.7:4582"
      ssm            = "http://192.168.0.7:4583"
      sts            = "http://192.168.0.7:4592"
      iam            = "http://192.168.0.7:4593"
    }
  }
