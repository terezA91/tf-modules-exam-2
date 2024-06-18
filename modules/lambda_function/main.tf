//There is a problem here

resource "aws_iam_role" "for-lambda-t" {
	name = "role-for-lambda"

	assume_role_policy = jsonencode({
		Version = "2012-10-17"
		Statement = [
			{
				Sid = "iamRoleForLambda"
				Effect = "Allow"
				Action = "sts:AssumeRole"
				Principal = {
					Service = "lambda.amazonaws.com"
				}
			}
		]
	})
	tags = {
		Name = "Role for lambda"			
	}
}

resource "aws_cloudwatch_log_group" "lf-loggroup" {
  name = "/aws/lambda/${aws_lambda_function.tf-lambda-up.function_name}"
}

data "aws_iam_policy_document" "policy-t" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      aws_cloudwatch_log_group.lf-loggroup.arn,
      "${aws_cloudwatch_log_group.lf-loggroup.arn}:*"
    ]
  }
}

resource "aws_iam_role_policy" "lambda_role_policy" {
  policy = data.aws_iam_policy_document.policy-t.json
  role   = aws_iam_role.for-lambda-t.id
  name   = "my-lambda-policy"
}

data "archive_file" "zip-of-content" {
  type = "zip"
  source_dir = var.source_path
  output_path = "${var.source_path}/file.zip"
}

resource "aws_lambda_function" "tf-lambda-up" {
  function_name = var.func_name
  filename = "${var.source_path}/file.zip"
  role = aws_iam_role.for-lambda-t.arn
  #ver handler = "${local.file_name}.lambda_handler"
  handler = "file.lambda_handler"
  runtime = var.runtime_lang
	depends_on = [var.object_for_reference]
}

resource "aws_lambda_permission" "alp" {
  statement_id = "AllowExecutionFromS3"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.tf-lambda-up.arn
  principal = var.principal
  source_arn = var.bucket_arn
}

