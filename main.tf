module "vpc" {
  source = "./modules/vpc"
}

module "autoscaling_group" {
  source = "./modules/asg"
  sec_group_id = module.vpc.sec_group_id
  pub_sub_a_id = module.vpc.pub_sub_a_id
  pub_sub_b_id = module.vpc.pub_sub_b_id
  user_data = "../../source_objects/docker_install.sh"
}

/*
module "s3" {
  source = "./modules/s3"
  enable_s3 = var.enable_s3
  bucket_name = var.bucket_name
  count = var.enable_s3 ? 1 : 0
  //count = var.enable_s3 ? 1 : 0

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
  //count = enable_lf == true ? 1 : 0
  //bucket_arn = module.wrapper.so == "some_val" ? sdsd : sdsd
  //bucket_arn = module.s3.bucket_arn
}

*/