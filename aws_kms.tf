resource "aws_kms_key" "sample" {
  enable_key_rotation = true
}

resource "aws_kms_alias" "sample" {
  name          = "alias/sample"
  target_key_id = aws_kms_key.sample.id
}
