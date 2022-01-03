data "aws_iam_policy_document" "lambda-execution-role" {
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "s3-object-lambda:WriteGetObjectResponse",
    ]
  }
}