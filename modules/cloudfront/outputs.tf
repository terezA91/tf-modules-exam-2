output "cf_name" {
  value = aws_cloudfront_distribution.cf
}

output "policy_for_cf" {
  value = data.aws_iam_policy_document.iam-policy.json
}
