locals {
	content = file(var.path)
	content_split = split(".", local.content)
	func_name = local.content_split[0]
	
}

resource "null_resource" "for_cli_cmd" {
  provisioner "local-exec" {
    command = "ls ${var.source_path} | head -1 > ${var.path}"
  }
}

resource "aws_iam_role" "for_lambda" {
	name = "role-for-lambda"
	assume_role_policy = jsonencode({
		Version = "2012-10-17"
		Statement = [
			{
				Sid = "IamRoleForLambda"
				Effect = "Allow"
				Action = "sts:AssumeRole"
				Principal = {
					Service = "lambda.amazonaws.com"
				}
			}
		]
	})
	tags = {
		Name = "Custom Lambda role"			
	}
}

resource "aws_cloudwatch_log_group" "lf_loggroup" {
  name = "/aws/lambda/${aws_lambda_function.tf-lambda-up.function_name}"
}

data "aws_iam_policy_document" "for_cloudwatch" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      aws_cloudwatch_log_group.lf_loggroup.arn,
      "${aws_cloudwatch_log_group.lf_loggroup.arn}:*",
    ]
  }
}

resource "aws_iam_role_policy" "lambda_role_policy" {
  policy = data.aws_iam_policy_document.for_cloudwatch.json
  role   = aws_iam_role.for_lambda.id
  name   = "For access to Cloudwatch"
}

data "archive_file" "zip_of_content" {
  type = "zip"
  source_dir = var.source_path
  output_path = "${var.source_path}/file.zip"
	depends_on = [null_resource.for_cli_cmd]
}

resource "aws_lambda_function" "tf_lambda" {
  function_name = "lf-alp"
  filename = "${var.source_path}/file.zip"
  role = aws_iam_role.for-lambda-t.arn
	handler = "${local.func_name}.lambda_handler"
  runtime = var.runtime_lang
}

resource "aws_lambda_permission" "alp" {
  statement_id = "AllowExecutionFromS3"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.tf_lambda.arn
  principal = var.principal
  source_arn = var.source_arn
}

resource "aws_s3_bucket_notification" "bn" {
  count = var.enable_lf ? 1 : 0
  bucket = var.origin_id
  lambda_function {
    lambda_function_arn = aws_lambda_function.tf_lambda.arn
    events = [var.lambda_trigger_event]
  }

  depends_on = [aws_lambda_permission.alp]
}

