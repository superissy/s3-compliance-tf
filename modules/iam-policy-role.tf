# ----------------------------------------------------------------
# IAM Policy for lambda role to access Config, S3 and SNS 
# ----------------------------------------------------------------


# IAM Policy for Config, S3 and SNS actions 
resource "aws_iam_policy_policy" "policydocument" {
  name   = "iam_lambda_access-tf"
  policy = data.aws_iam_policy_document.iam_lambda_access.json
}


#iam_lambda_access Policy Data 
data "aws_iam_policy_document" "iam_lambda_access" {
  statement {
    sid    = "S3Acccess"
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:Describe*",
      "s3:List*"
    ]
    resources = [
      "*"
    ]

  }

  statement {
    sid    = "ConfigRuleAccess"
    effect = "Allow"
    actions = [
      "config:Get*",
      "Config:Describe*",
      "Config:List*",
    ]
    resources = [
      "*"
    ]

  }

  statement {
    sid    = "SNSAcces"
    effect = "Allow"
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission"
    ]
    resources = [
      "aws_sns_topic.s3-lambda-sns.arn"
    ]

  }

}


# Lambda Execution Role 
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
