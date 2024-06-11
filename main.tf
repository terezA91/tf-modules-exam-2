module "vpc" {
  source = "./modules/vpc"
	enable_vpc = var.enable_vpc
	count = var.enable_vpc ? 1 : 0
}

module "app_lb" {
	source = "./modules/load_balancer"

	enable_alb = var.enable_alb
	vpc_id = module.vpc.vpc_id
	ec2_sec_group_id = module.vpc.ec2_sec_group
	alb_sec_group_id = module.vpc.alb_sec_group
	pub_sub_a_id = module.vpc.pub_sub_a_id
	pub_sub_b_id = module.vpc.pub_sub_b_id
	user_data = "../../source_objects/ip_addr.html"
}

module "autoscaling_group" {
  source = "./modules/autoscaling"

  enable_autoscaling = var.enable_autoscaling
  count = var.enable_autoscaling ? 1 : 0
  sec_group_id = module.vpc[0].sec_group_id
  pub_sub_a_id = module.vpc[0].pub_sub_a_id
  pub_sub_b_id = module.vpc[0].pub_sub_b_id
  user_data = "../../source_objects/docker_install.sh"
}


module "s3" {
  source = "./modules/s3"

  enable_s3 = var.enable_s3
  bucket_name = var.bucket_name
  count = var.enable_s3 ? 1 : 0

# >>>Lambda portion
	#trigger_lambda = var.trigger_lambda
  #lf_arn          = module.lambda.lf_arn
  #lf_permission  = module.lambda.lf_permission
# >>>CloudFront portion
  #cf_name       = module.cloudfront[0].cf_name
  #policy_for_cf = module.cloudfront[0].policy_for_cf
}

module "cloudfront" {
	source = "./modules/cloudfront"

	enable_cloudfront = var.enable_cloudfront
	count = var.enable_cloudfront ? 1 : 0
	s3_bucket_name     = module.s3[0].s3_bucket_name
  origin_domain_name = module.s3[0].domain_name
  origin_id          = module.s3[0].origin_id
  s3_bucket_arn      = module.s3[0].bucket_arn
}

/*
module "lambda" {
  source = "./modules/lambda_function"
  //count = enable_lf == true ? 1 : 0
  //bucket_arn = module.wrapper.so == "some_val" ? sdsd : sdsd
  //bucket_arn = module.s3.bucket_arn
}

*/
