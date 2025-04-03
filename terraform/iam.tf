
// Generic Lambda Role info
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "policy" {
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:*",
      "dax:*",
      "application-autoscaling:DeleteScalingPolicy",
      "application-autoscaling:DeregisterScalableTarget",
      "application-autoscaling:DescribeScalableTargets",
      "application-autoscaling:DescribeScalingActivities",
      "application-autoscaling:DescribeScalingPolicies",
      "application-autoscaling:PutScalingPolicy",
      "application-autoscaling:RegisterScalableTarget",
      "cloudwatch:DeleteAlarms",
      "cloudwatch:DescribeAlarmHistory",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:DescribeAlarmsForMetric",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:GetMetricData",
      "datapipeline:ActivatePipeline",
      "datapipeline:CreatePipeline",
      "datapipeline:DeletePipeline",
      "datapipeline:DescribeObjects",
      "datapipeline:DescribePipelines",
      "datapipeline:GetPipelineDefinition",
      "datapipeline:ListPipelines",
      "datapipeline:PutPipelineDefinition",
      "datapipeline:QueryObjects",
      "ec2:DescribeVpcs",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "iam:GetRole",
      "iam:ListRoles",
      "kms:DescribeKey",
      "kms:ListAliases",
      "sns:CreateTopic",
      "sns:DeleteTopic",
      "sns:ListSubscriptions",
      "sns:ListSubscriptionsByTopic",
      "sns:ListTopics",
      "sns:Subscribe",
      "sns:Unsubscribe",
      "sns:SetTopicAttributes",
      "lambda:CreateFunction",
      "lambda:ListFunctions",
      "lambda:ListEventSourceMappings",
      "lambda:CreateEventSourceMapping",
      "lambda:DeleteEventSourceMapping",
      "lambda:GetFunctionConfiguration",
      "lambda:DeleteFunction",
      "resource-groups:ListGroups",
      "resource-groups:ListGroupResources",
      "resource-groups:GetGroup",
      "resource-groups:GetGroupQuery",
      "resource-groups:DeleteGroup",
      "resource-groups:CreateGroup",
      "tag:GetResources",
      "kinesis:ListStreams",
      "kinesis:DescribeStream",
      "kinesis:DescribeStreamSummary"
    ]
    resources = ["*"]
  }
}

// Cubs Lambda Role Info
resource "aws_iam_policy" "policy" {
  name        = "CfaTfPolicy"
  description = "Test out text alerts for hawks and cubs with Terraform!"
  policy      = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_role" "terraform_function_role" {
  name               = "cubs-cfa-texter-tf"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}


resource "aws_iam_role_policy_attachment" "terraform_lambda_policy" {
  role       = aws_iam_role.terraform_function_role.name
  policy_arn = aws_iam_policy.policy.arn
}


// Hakws Lambda Roles
resource "aws_iam_role" "hawks_role" {
  name               = "hawks-cfa-texter-tf"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "hawks_terraform_lambda_policy" {
  role       = aws_iam_role.hawks_role.name
  policy_arn = aws_iam_policy.policy.arn
}
