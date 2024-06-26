module "vpc" {
  source = "./modules/vpc"

  enable_vpc = var.enable_vpc
  count      = var.enable_vpc ? 1 : 0
}

module "app_lb" {
  source = "./modules/load_balancer"

  enable_elb    = var.enable_elb
  count         = var.enable_elb ? 1 : 0
  vpc           = module.vpc[0].vpc_id
  elb_pub_sub_a = module.vpc[0].pub_sub_a_id
  elb_pub_sub_b = module.vpc[0].pub_sub_b_id
}

module "autoscaling_group" {
  source = "./modules/autoscaling"

  enable_autoscaling = var.enable_autoscaling
  count              = var.enable_autoscaling ? 1 : 0
  pub_sub_a          = module.vpc[0].pub_sub_a_id
  pub_sub_b          = module.vpc[0].pub_sub_b_id
  elb                = module.app_lb[0].elb
  lt_userdata        = var.lt_userdata
  instance_sec_group = module.app_lb[0].instance_sec_group
}


module "s3" {
  source = "./modules/s3"

  enable_s3      = var.enable_s3
  with_cf        = var.with_cf
  count          = var.enable_s3 ? 1 : 0
  bucket_name    = var.bucket_name
  s3_object_path = var.s3_object_path

  # >>>Lambda portion
  trigger_lambda = var.trigger_lambda
  lf_arn         = var.trigger_lambda ? module.lambda[0].lf_arn : null
  lf_permission  = var.trigger_lambda ? module.lambda[0].lf_permission : null
  # >>>CloudFront portion
  cf_name       = var.with_cf ? module.cloudfront[0].cf_name : null
  policy_for_cf = var.with_cf ? module.cloudfront[0].policy_for_cf : null
}

module "cloudfront" {
  source = "./modules/cloudfront"

  enable_cloudfront  = var.enable_cloudfront
  count              = var.enable_cloudfront ? 1 : 0
  origin_name        = module.s3[0].s3_bucket_name
  origin_domain_name = module.s3[0].domain_name
  cf_origin_id       = module.s3[0].origin_id
  origin_arn         = module.s3[0].bucket_arn
}


module "lambda" {
  source = "./modules/lambda_function"

  enable_lf   = var.enable_lf
  count       = var.enable_lf ? 1 : 0
  path        = var.path
  source_path = var.source_path
  source_arn  = module.s3[0].bucket_arn
  origin_id   = module.s3[0].origin_id
}

module "ec2_instance" {
  source = "./modules/ec2_instance"

  enable_ec2     = var.enable_ec2
  count          = var.enable_ec2 ? 1 : 0
  ec2_pub_sub_a  = module.vpc[0].pub_sub_a_id
  ec2_pub_sub_b  = module.vpc[0].pub_sub_b_id
  ec2_priv_sub_a = module.vpc[0].priv_sub_a_id
  ec2_priv_sub_b = module.vpc[0].priv_sub_b_id
  sec_group_id   = module.vpc[0].sec_group_id
  user_data      = var.user_data
  user_data_2    = var.user_data_2
}
