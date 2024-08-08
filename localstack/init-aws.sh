#!/bin/bash

# SNS
awslocal sns create-topic --name fiap-irango-order_order-created_dev

awslocal sns create-topic --name fiap-irango-payment_payment-created_dev
awslocal sns create-topic --name fiap-irango-payment_payment-confirmed_dev

awslocal sns create-topic --name fiap-irango-cook_cooking-started_dev
awslocal sns create-topic --name fiap-irango-cook_cooking-finished_dev

# SQS
awslocal sqs create-queue --queue-name fiap-irango-payment_order-created_dev
awslocal sqs create-queue --queue-name fiap-irango-payment_gateway-postbacks_dev # TODO - Verificar se é necessário
awslocal sqs create-queue --queue-name fiap-irango-order_payment-created_dev
awslocal sqs create-queue --queue-name fiap-irango-order_payment-confirmed_dev
awslocal sqs create-queue --queue-name fiap-irango-cook_payment-confirmed_dev
awslocal sqs create-queue --queue-name fiap-irango-order_cooking-started_dev
awslocal sqs create-queue --queue-name fiap-irango-order_cooking-finished_dev

# SNS -> SQS
awslocal sns subscribe \
  --endpoint-url=http://sqs.us-east-1.localhost.localstack.cloud:4566 \
  --region us-east-1 \
  --protocol sqs \
  --topic-arn arn:aws:sns:us-east-1:000000000000:fiap-irango-order_order-created_dev \
  --notification-endpoint arn:aws:sqs:us-east-1:000000000000:fiap-irango-payment_order-created_dev

awslocal sns subscribe \
  --endpoint-url=http://sqs.us-east-1.localhost.localstack.cloud:4566 \
  --region us-east-1 \
  --protocol sqs \
  --topic-arn arn:aws:sns:us-east-1:000000000000:fiap-irango-payment_payment-created_dev \
  --notification-endpoint arn:aws:sqs:us-east-1:000000000000:fiap-irango-order_payment-created_dev

awslocal sns subscribe \
  --endpoint-url=http://sqs.us-east-1.localhost.localstack.cloud:4566 \
  --region us-east-1 \
  --protocol sqs \
  --topic-arn arn:aws:sns:us-east-1:000000000000:fiap-irango-payment_payment-confirmed_dev \
  --notification-endpoint arn:aws:sqs:us-east-1:000000000000:fiap-irango-order_payment-confirmed_dev

awslocal sns subscribe \
  --endpoint-url=http://sqs.us-east-1.localhost.localstack.cloud:4566 \
  --region us-east-1 \
  --protocol sqs \
  --topic-arn arn:aws:sns:us-east-1:000000000000:fiap-irango-payment_payment-confirmed_dev \
  --notification-endpoint arn:aws:sqs:us-east-1:000000000000:fiap-irango-cook_payment-confirmed_dev

awslocal sns subscribe \
  --endpoint-url=http://sqs.us-east-1.localhost.localstack.cloud:4566 \
  --region us-east-1 \
  --protocol sqs \
  --topic-arn arn:aws:sns:us-east-1:000000000000:fiap-irango-cook_cooking-started_dev \
  --notification-endpoint arn:aws:sqs:us-east-1:000000000000:fiap-irango-order_cooking-started_dev

awslocal sns subscribe \
  --endpoint-url=http://sqs.us-east-1.localhost.localstack.cloud:4566 \
  --region us-east-1 \
  --protocol sqs \
  --topic-arn arn:aws:sns:us-east-1:000000000000:fiap-irango-cook_cooking-finished_dev \
  --notification-endpoint arn:aws:sqs:us-east-1:000000000000:fiap-irango-order_cooking-finished_dev
