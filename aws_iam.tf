resource "aws_iam_role" "sqs_feedback_role" {
  name = "sqs_feedback"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "sns.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "sqs_feedback_policy" {
  name = "sqs_feedback_policy"
  role = aws_iam_role.sqs_feedback_role.name

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:PutMetricFilter",
          "logs:PutRetentionPolicy"
        ],
        "Resource" : [
          aws_sns_topic.sample.arn
        ]
      }
    ]
  })
}
