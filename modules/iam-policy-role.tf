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
resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = "${data.aws_iam_policy_document.policy.json}"
}


data "aws_iam_policy_document" "policy" {
  statement {
    sid    = ""
    effect = "Allow"

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}

