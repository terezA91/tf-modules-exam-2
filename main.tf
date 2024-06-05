module "s3" {
  source = "./modules/s3"
  //count = var.enable_s3 ? 1 : 0
  count = module.wrapper.so == "some_value" ? 1 : 0
# >>>Lambda portion
 	#trigger_lambda = true
  #lf_arn          = module.lambda.lf_arn
  #lf_permission  = module.lambda.lf_permission
# >>>CloudFront portion
# cf_name       = module.cf_distribution.cf_name
# policy_for_cf = module.cf_distribution.policy_for_cf
}


module "lambda" {
  source = "./modules/lambda_function"
  count = enable_lf == true ? 1 : 0
  //bucket_arn = module.wrapper.so == "some_val" ? sdsd : sdsd
  //bucket_arn = module.s3.bucket_arn
}
