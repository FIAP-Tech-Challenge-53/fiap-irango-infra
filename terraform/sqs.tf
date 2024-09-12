# =====================================================
# =============== payment_order-created ===============
# =====================================================
resource "aws_sqs_queue" "payment_order_created_dlq" {
  name                       = "${var.resource_prefix}-payment_order-created_dlq"
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 30

  tags = {
    Name = "${var.resource_prefix}-payment_order-created-dlq"
  }
}

resource "aws_sqs_queue" "payment_order_created" {
  name                       = "${var.resource_prefix}-payment_order-created"
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 30

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.payment_order_created_dlq.arn
    maxReceiveCount     = 4
  })

  # policy = "${data.aws_iam_policy_document.sqs-topic-policy-hlg.json}" # TODO - Verificar se é necessário

  tags = {
    Name = "${var.resource_prefix}-payment_order-created-queue"
  }
}

resource "aws_sns_topic_subscription" "payment_order_created_subscription" {
  topic_arn = aws_sns_topic.order_order_created.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.payment_order_created.arn
}

data "aws_iam_policy_document" "payment_order_created_policy" {
  statement {
    sid    = "First"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.payment_order_created.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_sns_topic.order_order_created.arn]
    }
  }
}

resource "aws_sqs_queue_policy" "payment_order_created_queue_policy" {
  queue_url = aws_sqs_queue.payment_order_created.id
  policy    = data.aws_iam_policy_document.payment_order_created_policy.json
}


# =====================================================
# =============== cook_order-created ===============
# =====================================================
resource "aws_sqs_queue" "cook_order_created_dlq" {
  name                       = "${var.resource_prefix}-cook_order-created_dlq"
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 30

  tags = {
    Name = "${var.resource_prefix}-cook_order-created-dlq"
  }
}

resource "aws_sqs_queue" "cook_order_created" {
  name                       = "${var.resource_prefix}-cook_order-created"
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 30

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.cook_order_created_dlq.arn
    maxReceiveCount     = 4
  })

  # policy = "${data.aws_iam_policy_document.sqs-topic-policy-hlg.json}" # TODO - Verificar se é necessário

  tags = {
    Name = "${var.resource_prefix}-cook_order-created-queue"
  }
}

resource "aws_sns_topic_subscription" "cook_order_created_subscription" {
  topic_arn = aws_sns_topic.order_order_created.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.cook_order_created.arn
}

data "aws_iam_policy_document" "cook_order_created_policy" {
  statement {
    sid    = "First"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.cook_order_created.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_sns_topic.order_order_created.arn]
    }
  }
}

resource "aws_sqs_queue_policy" "cook_order_created_queue_policy" {
  queue_url = aws_sqs_queue.cook_order_created.id
  policy    = data.aws_iam_policy_document.cook_order_created_policy.json
}

# =====================================================
# ============== order_payment-created ==============
# =====================================================
resource "aws_sqs_queue" "order_payment_created_dlq" {
  name                       = "${var.resource_prefix}-order_payment-created_dlq"
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 30

  tags = {
    Name = "${var.resource_prefix}-order_payment-created-dlq"
  }
}

resource "aws_sqs_queue" "order_payment_created" {
  name                       = "${var.resource_prefix}-order_payment-created"
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 30

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.order_payment_created_dlq.arn
    maxReceiveCount     = 4
  })

  # policy = "${data.aws_iam_policy_document.sqs-topic-policy-hlg.json}" # TODO - Verificar se é necessário

  tags = {
    Name = "${var.resource_prefix}-order_payment-created-queue"
  }
}

resource "aws_sns_topic_subscription" "order_payment_created_subscription" {
  topic_arn = aws_sns_topic.payment_payment_created.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.order_payment_created.arn
}

data "aws_iam_policy_document" "order_payment_created_policy" {
  statement {
    sid    = "First"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.order_payment_created.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_sns_topic.payment_payment_created.arn]
    }
  }
}

resource "aws_sqs_queue_policy" "order_payment_created_queue_policy" {
  queue_url = aws_sqs_queue.order_payment_created.id
  policy    = data.aws_iam_policy_document.order_payment_created_policy.json
}

# =====================================================
# ============= payment_gateway-postbacks =============
# =====================================================
resource "aws_sqs_queue" "payment_gateway_postbacks_dlq" {
  name                       = "${var.resource_prefix}-payment_gateway-postbacks_dlq"
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 30

  tags = {
    Name = "${var.resource_prefix}-payment_gateway-postbacks-dlq"
  }
}

resource "aws_sqs_queue" "payment_gateway_postbacks" {
  name                       = "${var.resource_prefix}-payment_gateway-postbacks"
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 30

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.payment_gateway_postbacks_dlq.arn
    maxReceiveCount     = 4
  })

  # policy = "${data.aws_iam_policy_document.sqs-topic-policy-hlg.json}" # TODO - Verificar se é necessário

  tags = {
    Name = "${var.resource_prefix}-payment_gateway-postbacks-queue"
  }
}

# =====================================================
# ============== order_payment-confirmed ==============
# =====================================================
resource "aws_sqs_queue" "payment_confirmed_dlq" {
  name                       = "${var.resource_prefix}-order_payment-confirmed_dlq"
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 30

  tags = {
    Name = "${var.resource_prefix}-order_payment-confirmed-dlq"
  }
}

resource "aws_sqs_queue" "order_payment_confirmed" {
  name                       = "${var.resource_prefix}-order_payment-confirmed"
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 30

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.payment_confirmed_dlq.arn
    maxReceiveCount     = 4
  })

  # policy = "${data.aws_iam_policy_document.sqs-topic-policy-hlg.json}" # TODO - Verificar se é necessário

  tags = {
    Name = "${var.resource_prefix}-order_payment-confirmed-queue"
  }
}

resource "aws_sns_topic_subscription" "order_payment_confirmed_subscription" {
  topic_arn = aws_sns_topic.payment_payment_confirmed.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.order_payment_confirmed.arn
}

data "aws_iam_policy_document" "order_payment_confirmed_policy" {
  statement {
    sid    = "First"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.order_payment_confirmed.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_sns_topic.payment_payment_confirmed.arn]
    }
  }
}

resource "aws_sqs_queue_policy" "order_payment_confirmed_queue_policy" {
  queue_url = aws_sqs_queue.order_payment_confirmed.id
  policy    = data.aws_iam_policy_document.order_payment_confirmed_policy.json
}

# =====================================================
# =============== cook_payment-confirmed ==============
# =====================================================
resource "aws_sqs_queue" "cook_payment_confirmed_dlq" {
  name                       = "${var.resource_prefix}-cook_payment-confirmed_dlq"
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 30

  tags = {
    Name = "${var.resource_prefix}-cook_payment-confirmed-dlq"
  }
}

resource "aws_sqs_queue" "cook_payment_confirmed" {
  name                       = "${var.resource_prefix}-cook_payment-confirmed"
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 30

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.cook_payment_confirmed_dlq.arn
    maxReceiveCount     = 4
  })

  # policy = "${data.aws_iam_policy_document.sqs-topic-policy-hlg.json}" # TODO - Verificar se é necessário

  tags = {
    Name = "${var.resource_prefix}-cook_payment-confirmed-queue"
  }
}

resource "aws_sns_topic_subscription" "cook_payment_confirmed_subscription" {
  topic_arn = aws_sns_topic.payment_payment_confirmed.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.cook_payment_confirmed.arn
}

data "aws_iam_policy_document" "cook_payment_confirmed_policy" {
  statement {
    sid    = "First"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.cook_payment_confirmed.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_sns_topic.payment_payment_confirmed.arn]
    }
  }
}

resource "aws_sqs_queue_policy" "cook_payment_confirmed_queue_policy" {
  queue_url = aws_sqs_queue.cook_payment_confirmed.id
  policy    = data.aws_iam_policy_document.cook_payment_confirmed_policy.json
}

# =====================================================
# =============== order_cooking-started ===============
# =====================================================
resource "aws_sqs_queue" "order_cooking_started_dlq" {
  name                       = "${var.resource_prefix}-order_cooking-started_dlq"
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 30

  tags = {
    Name = "${var.resource_prefix}-order_cooking-started-dlq"
  }
}

resource "aws_sqs_queue" "order_cooking_started" {
  name                       = "${var.resource_prefix}-order_cooking-started"
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 30

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.order_cooking_started_dlq.arn
    maxReceiveCount     = 4
  })

  # policy = "${data.aws_iam_policy_document.sqs-topic-policy-hlg.json}" # TODO - Verificar se é necessário

  tags = {
    Name = "${var.resource_prefix}-order_cooking-started-queue"
  }
}

resource "aws_sns_topic_subscription" "order_cooking_started_subscription" {
  topic_arn = aws_sns_topic.cook_cooking_started.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.order_cooking_started.arn
}

data "aws_iam_policy_document" "order_cooking_started_policy" {
  statement {
    sid    = "First"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.order_cooking_started.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_sns_topic.cook_cooking_started.arn]
    }
  }
}

resource "aws_sqs_queue_policy" "order_cooking_started_queue_policy" {
  queue_url = aws_sqs_queue.order_cooking_started.id
  policy    = data.aws_iam_policy_document.order_cooking_started_policy.json
}

# =====================================================
# =============== order_cooking-finished ==============
# =====================================================
resource "aws_sqs_queue" "order_cooking_finished_dlq" {
  name                       = "${var.resource_prefix}-order_cooking-finished_dlq"
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 30

  tags = {
    Name = "${var.resource_prefix}-order_cooking-finished-dlq"
  }
}

resource "aws_sqs_queue" "order_cooking_finished" {
  name                       = "${var.resource_prefix}-order_cooking-finished"
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 30

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.order_cooking_finished_dlq.arn
    maxReceiveCount     = 4
  })

  # policy = "${data.aws_iam_policy_document.sqs-topic-policy-hlg.json}" # TODO - Verificar se é necessário

  tags = {
    Name = "${var.resource_prefix}-order_cooking-finished-queue"
  }
}

resource "aws_sns_topic_subscription" "order_cooking_finished_subscription" {
  topic_arn = aws_sns_topic.cook_cooking_finished.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.order_cooking_finished.arn
}

data "aws_iam_policy_document" "order_cooking_finished_policy" {
  statement {
    sid    = "First"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.order_cooking_finished.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_sns_topic.cook_cooking_finished.arn]
    }
  }
}

resource "aws_sqs_queue_policy" "order_cooking_finished_queue_policy" {
  queue_url = aws_sqs_queue.order_cooking_finished.id
  policy    = data.aws_iam_policy_document.order_cooking_finished_policy.json
}
