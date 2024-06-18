output "lf_arn" {
    value = aws_lambda_function.tf-lambda-up.arn
    description = "Arn of lambda function"
}

output "lf_arn_2" {
    value = aws_lambda_function.tf-lambda-up.arn
    description = "Arn of lambda function"
}

output "lf_permission" {
    value = aws_lambda_permission.alp
    description = "Name of the <aws_lambda_permission> resource"
}

output "lf_perm_2" {
    value = aws_lambda_permission.alp
    description = "Name of the <aws_lambda_permission> resource"
}
