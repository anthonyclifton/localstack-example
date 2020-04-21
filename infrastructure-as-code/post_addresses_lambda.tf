data "archive_file" "post_addresses_lambda_zip" {
  type = "zip"
  source_file = "../resources/post_addresses/index.js"
  output_path = "post_addresses_lambda_function.zip"
}

resource "aws_lambda_function" "post-addresses-lambda" {
  filename = "post_addresses_lambda_function.zip"
  function_name = "post_addresses_lambda"
  role = "${aws_iam_role.iam_for_lambda_tf.arn}"
  handler = "index.handler"
  source_code_hash = "${data.archive_file.post_addresses_lambda_zip.output_base64sha256}"
  runtime = "nodejs10.x"
  memory_size = 128
}

resource "aws_lambda_permission" "apigw-invoke-post-addresses-lambda" {
  statement_id = "AllowAPIGatewayInvoke"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.post-addresses-lambda.arn}"
  principal = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the specified API Gateway.
  source_arn = "${aws_api_gateway_deployment.addresses-api-gateway-deployment.execution_arn}/*/*"
}