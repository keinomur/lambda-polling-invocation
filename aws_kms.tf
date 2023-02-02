resource "aws_kms_key" "sample" {
  enable_key_rotation = true

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        AWS = "*"
      },
      Action = [
        "kms:*"
      ],
      Resource = ["*"]
    }]
  })
}

resource "aws_kms_alias" "sample" {
  name          = "alias/sample"
  target_key_id = aws_kms_key.sample.id
}
