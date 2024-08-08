resource "aws_sns_topic" "order_order_created" {
  name = "${var.resource_prefix}-order_order-created"

  tags = {
    Name = "${var.resource_prefix}-order_order-created-topic"
  }
}

resource "aws_sns_topic" "payment_payment_created" {
  name = "${var.resource_prefix}-payment_payment-created"

  tags = {
    Name = "${var.resource_prefix}-payment_payment-created-topic"
  }
}

resource "aws_sns_topic" "payment_payment_confirmed" {
  name = "${var.resource_prefix}-payment_payment-confirmed"

  tags = {
    Name = "${var.resource_prefix}-payment_payment-confirmed-topic"
  }
}

resource "aws_sns_topic" "cook_cooking_started" {
  name = "${var.resource_prefix}-cook_cooking-started"

  tags = {
    Name = "${var.resource_prefix}-cook_cooking-started-topic"
  }
}

resource "aws_sns_topic" "cook_cooking_finished" {
  name = "${var.resource_prefix}-cook_cooking-finished"

  tags = {
    Name = "${var.resource_prefix}-cook_cooking-finished-topic"
  }
}