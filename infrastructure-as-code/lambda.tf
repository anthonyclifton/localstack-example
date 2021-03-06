data "archive_file" "lambda_zip" {
  type = "zip"
  source_file = "../resources/backend/index.js"
  output_path = "lambda_function.zip"
}

resource "aws_lambda_function" "test_lambda" {
  filename = "lambda_function.zip"
  function_name = "test_lambda"
  role = "${aws_iam_role.iam_for_lambda_tf.arn}"
  handler = "index.handler"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime = "nodejs10.x"
}

resource "aws_iam_role" "iam_for_lambda_tf" {
  name = "iam_for_lambda_tf"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
      "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
                       "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
      ]
  }
EOF
}

resource "aws_lambda_permission" "apigw" {
    statement_id = "AllowAPIGatewayInvoke"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.test_lambda.function_name
    principal = "apigateway.amazonaws.com"

    # The "/*/*/" portion grants access from any method on any resource
    # within the API gateway REST API.
    source_arn = "${aws_api_gateway_rest_api.hello.execution_arn}/*/*"
}

resource "aws_iam_role_policy" "dynamodb-lambda-policy" {
    name = "dynamodb_lambda_policy"
    role = "${aws_iam_role.iam_for_lambda_tf.id}"

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:*"
      ],
      "Resource": "${aws_dynamodb_table.addresses-table.arn}"
    }
    ]
  }
EOF
}