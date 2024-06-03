module "s3" {
  source = "./modules/s3"
  count = create_s3 == true ? 1 : 0
# >>>Lambda portion
 	trigger_lambda = true
  lf_arn          = module.lambda.lf_arn
  lf_permission  = module.lambda.lf_permission
# >>>CloudFront portion
# cf_name       = module.cf_distribution.cf_name
# policy_for_cf = module.cf_distribution.policy_for_cf
}


module "lambda" {
  source = "./modules/lambda_function"

  bucket_arn = module.s3.bucket_arn
}
