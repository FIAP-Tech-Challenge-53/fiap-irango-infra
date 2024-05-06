# Crie um API Gateway
resource "aws_api_gateway_rest_api" "fiap_gateway" {
  name        = "fiap_gateway-api"
  description = "Fiap API Gateway"

  endpoint_configuration {
    types = ["REGIONAL"]
    # vpc_endpoint_ids = [aws_vpc.default.id]
  }
}

# Crie um recurso na API Gateway
resource "aws_api_gateway_resource" "fiap_gateway_resource" {
  rest_api_id = aws_api_gateway_rest_api.fiap_gateway.id
  parent_id   = aws_api_gateway_rest_api.fiap_gateway.root_resource_id
  path_part   = "login"
}

# Defina um método na API Gateway (por exemplo, GET)
resource "aws_api_gateway_method" "fiap_gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.fiap_gateway.id
  resource_id   = aws_api_gateway_resource.fiap_gateway_resource.id
  http_method   = "GET"
  authorization = "NONE"
}


output "gateway_id" {
  value = aws_api_gateway_rest_api.fiap_gateway.id
}

output "gateway_resource_id" {
  value = aws_api_gateway_resource.fiap_gateway_resource.id
}

output "gateway_http_method" {
  value = aws_api_gateway_method.fiap_gateway_method.http_method
}

output "gateway_execution_arn" {
  value = aws_api_gateway_rest_api.fiap_gateway.execution_arn
}