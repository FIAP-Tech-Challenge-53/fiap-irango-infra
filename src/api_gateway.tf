# Crie um API Gateway
resource "aws_api_gateway_rest_api" "fiap_gateway" {
  name        = "fiap-gateway-api"
  description = "Fiap API Gateway"
}

# Crie um recurso na API Gateway
resource "aws_api_gateway_resource" "fiap-gateway_resource" {
  rest_api_id = aws_api_gateway_rest_api.fiap_gateway.id
  parent_id   = aws_api_gateway_rest_api.fiap_gateway.root_resource_id
  path_part   = "fiap-gateway"
}

# Defina um método na API Gateway (por exemplo, GET)
resource "aws_api_gateway_method" "fiap-gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.fiap_gateway.id
  resource_id   = aws_api_gateway_resource.fiap-gateway_resource.id
  http_method   = "GET"
  authorization = "NONE"
}



# Crie uma resposta para o método da API Gateway
resource "aws_api_gateway_method_response" "fiap-gateway_method_response" {
  rest_api_id = aws_api_gateway_rest_api.fiap_gateway.id
  resource_id = aws_api_gateway_resource.fiap-gateway_resource.id
  http_method = aws_api_gateway_method.fiap-gateway_method.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Content-Type" = true
  }

  response_models = {
    "application/json" = "Empty"
  }
}

# Crie uma resposta de integração para o método da API Gateway
resource "aws_api_gateway_integration_response" "fiap-gateway_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.fiap_gateway.id
  resource_id = aws_api_gateway_resource.fiap-gateway_resource.id
  http_method = aws_api_gateway_method.fiap-gateway_method.http_method
  status_code = aws_api_gateway_method_response.fiap-gateway_method_response.status_code

  response_templates = {
    "application/json" = ""
  }

   depends_on = [
    aws_api_gateway_method_response.fiap-gateway_method_response
  ]
}

output "gateway_id" {
  value = aws_api_gateway_rest_api.fiap_gateway.id
}

output "gateway_resource_id" {
  value = aws_api_gateway_resource.fiap-gateway_resource.id
}

output "gateway_http_method" {
  value = aws_api_gateway_method.fiap-gateway_method.http_method
}

output "gateway_execution_arn" {
  value = aws_api_gateway_rest_api.fiap_gateway.execution_arn
}