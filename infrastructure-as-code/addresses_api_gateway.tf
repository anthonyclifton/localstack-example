resource "aws_api_gateway_rest_api" "addresses-api-gateway" {
  name = "AddressesAPI"
  description = "API to access Addresses application"
}

resource "aws_api_gateway_resource" "addresses-proxy" {
  rest_api_id = aws_api_gateway_rest_api.addresses-api-gateway.id
  parent_id = aws_api_gateway_rest_api.addresses-api-gateway.root_resource_id
  path_part = "api"
}

resource "aws_api_gateway_method" "addresses-proxy" {
  rest_api_id = aws_api_gateway_rest_api.addresses-api-gateway.id
  resource_id = aws_api_gateway_resource.addresses-proxy.id
  http_method = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "addresses-lambda" {
  rest_api_id = aws_api_gateway_rest_api.addresses-api-gateway.id
  resource_id = aws_api_gateway_method.addresses-proxy.resource_id
  http_method = aws_api_gateway_method.addresses-proxy.http_method

  integration_http_method = "GET"
  type = "AWS_PROXY"
  uri = aws_lambda_function.get-addresses-lambda.invoke_arn
}

resource "aws_api_gateway_method" "addresses-lambda-root" {
  rest_api_id = aws_api_gateway_rest_api.addresses-api-gateway.id
  resource_id = aws_api_gateway_rest_api.addresses-api-gateway.root_resource_id
  http_method = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "addresses-lambda-root" {
  rest_api_id = aws_api_gateway_rest_api.addresses-api-gateway.id
  resource_id = aws_api_gateway_method.addresses-lambda-root.resource_id
  http_method = aws_api_gateway_method.addresses-lambda-root.http_method

  integration_http_method = "GET"
  type = "AWS_PROXY"
  uri = aws_lambda_function.get-addresses-lambda.invoke_arn
}

resource "aws_api_gateway_deployment" "addresses-api-gateway-deployment" {
  depends_on = [
    aws_api_gateway_integration.addresses-lambda,
    aws_api_gateway_integration.addresses-lambda-root,
  ]
  rest_api_id = "${aws_api_gateway_rest_api.addresses-api-gateway.id}"
  stage_name = "addresses"
}

output "addresses_api_url" {
  value = "${aws_api_gateway_deployment.addresses-api-gateway-deployment.invoke_url}/api"
}