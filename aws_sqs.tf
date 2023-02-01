resource "aws_sqs_queue" "sample" {
  name                      = "sample"
  receive_wait_time_seconds = 20

  # MEMO: https://stackoverflow.com/questions/44585726/how-do-i-write-the-policy-statement-of-an-encrypted-sqs-for-s3-events
  # kms_master_key_id = aws_kms_alias.sample.name
  # policy = jsonencode({
  #   "Version" : "2012-10-17",
  #   "Statement" : [
  #     {
  #       "Effect" : "Allow",
  #       "Action" : [
  #         "kms:*"
  #       ],
  #       "Resource" : [
  #         aws_kms_key.sample.arn
  #       ]
  #     }
  #   ]
  # })
}

resource "aws_sqs_queue_policy" "sample" {
  queue_url = aws_sqs_queue.sample.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.sample.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.sample.arn}"
        }
      }
    }
  ]
}
POLICY
}
