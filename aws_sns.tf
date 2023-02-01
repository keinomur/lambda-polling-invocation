resource "aws_sns_topic" "sample" {
  name = "sample"
  # kms_master_key_id                = aws_kms_alias.sample.name
  sqs_success_feedback_sample_rate = 0
  sqs_success_feedback_role_arn    = aws_iam_role.sqs_feedback_role.arn
  sqs_failure_feedback_role_arn    = aws_iam_role.sqs_feedback_role.arn
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.sample.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.sample.arn
}
