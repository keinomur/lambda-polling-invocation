resource "aws_sqs_queue" "sample" {
  name                      = "sample"
  kms_master_key_id         = aws_kms_alias.sample.name
  receive_wait_time_seconds = 20
}

resource "aws_sqs_queue_policy" "sample" {
  queue_url = aws_sqs_queue.sample.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "sns.amazonaws.com"
      },
      Action   = ["sqs:SendMessage"],
      Resource = [aws_sqs_queue.sample.arn]
      Condition = {
        ArnEquals = {
          "aws:SourceArn" = aws_sns_topic.sample.arn
        }
      }
    }]
  })
}
