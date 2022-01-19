resource "aws_sns_topic" "s3-lambda-sns" {
  name = var.sns_name
}
