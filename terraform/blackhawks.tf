

module "hawks_lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name          = "blackhawks-cfa-texter"
  description            = "Lambda Function to send text alerts about free Chick-fil-a breakfast when the blackhawks score."
  handler                = "free_cfa.lambda_handler"
  runtime                = "python3.13"
  timeout                = 90
  create_package         = false
  maximum_retry_attempts = 0
  attach_policy          = true
  policy                 = aws_iam_policy.policy.arn
  local_existing_package = "../package.zip" # Dummy zip to be updated via a Github Action
  # Have to re-add IAM role for dynamodb full read access
  environment_variables = {
    TWILIO_ACCOUNT_SID = var.twilio_account_sid
    TWILIO_AUTH_TOKEN  = var.twilio_auth_token
    SENDER_NUMBER      = var.sender_number
  }
}

# resource "aws_iam_policy" "hawks_policy" {
#   name        = "BlackhawksCfaTfPolicy"
#   description = "Test out text alerts for blackhawks with Terraform!"
#   policy      = data.aws_iam_policy_document.policy.json
# }

resource "aws_iam_role" "hawks_role" {
  name               = "hawks-cfa-texter-tf"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "hawks_terraform_lambda_policy" {
  role       = aws_iam_role.hawks_role.name
  policy_arn = aws_iam_policy.policy.arn
}
