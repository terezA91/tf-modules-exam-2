locals {
  ob_name_split = split(".", var.s3_object_path)
  ct_value      = local.ob_name_split[1]
  content_type = {
    html = "text/html"
    css  = "text/css"
    jpeg = "image/jpeg"
    jpg  = "image/jpeg"
    json = "application/json"
    mp4  = "video/mp4"
    png  = "image/png"
    pdf  = "application/pdf"
    xls  = "application/vnd.ms-excel"
  }
}

resource "aws_s3_bucket" "b1" {
  #count = var.directory_bucket ? 0 : 1
  bucket = var.bucket_name
  #bucket_prefix = var.bucket_prefix  //for unique bucket_name
  force_destroy = var.destroy_bucket
	//depends_on = [aws_s3_bucket_policy.s3_tf_policy]

  tags = {
    Name = var.bucket_tag_name
  }
}

resource "aws_s3_object" "ob" {
  bucket = aws_s3_bucket.b1.bucket
  source = var.s3_object_path
  key          = "${local.ct_value}-object"
  content_type = lookup(local.content_type, local.ct_value)
  server_side_encryption = var.sse_type
	depends_on = [aws_s3_bucket_policy.s3_tf_policy]
}

resource "aws_s3_bucket_public_access_block" "exam" {
  bucket                  = aws_s3_bucket.b1.id
  block_public_acls       = var.s3_block_public_acls
  block_public_policy     = var.s3_block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.s3_restrict_public_buckets
}

resource "aws_s3_bucket_versioning" "bv" {
  bucket = aws_s3_bucket.b1.id
  versioning_configuration {
    status = var.enable_versioning
  }
}

resource "aws_s3_bucket_accelerate_configuration" "s1" {
  count  = var.accelerate ? 1 : 0
  bucket = aws_s3_bucket.b1.id
  status = "Enabled"
}

resource "aws_s3_bucket_ownership_controls" "s1" {
  count  = var.enable_acl ? 1 : 0
  bucket = aws_s3_bucket.b1.id
  rule {
    object_ownership = var.ownership_type
  }
}

resource "aws_s3_bucket_policy" "s3_tf_policy" {
  bucket = aws_s3_bucket.b1.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "Policy1234567890123",
    "Statement" : [
      {
        "Sid" : "Stmt1234567890123",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "s3:GetObject",
        "Resource" : [
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
      }
    ]
  })
	depends_on = [aws_s3_bucket.b1]
}

resource "aws_s3_bucket_policy" "for_cf" {
	count      = var.with_cf ? 1 : 0
  bucket     = aws_s3_bucket.b1.id
  policy     = var.policy_for_cf
  depends_on = [var.cf_name]
}

resource "aws_s3_bucket_notification" "bn" {
	count = var.trigger_lambda == true ? 1 : 0
  bucket = aws_s3_bucket.b1.id
  lambda_function {
    lambda_function_arn = var.lf_arn
    //events = ["s3:ObjectCreated:*"]
		events = [var.lambda_trigger_event]
  }
	
	depends_on = [var.lf_permission]
}





/*
locals {
  ob_name_split = split(".", var.s3_object_path)
  ct_value      = local.ob_name_split[1]

  content_type = {
    html = "text/html"
    css  = "text/css"
    jpeg = "image/jpeg"
    jpg  = "image/jpeg"
    json = "application/json"
    mp4  = "video/mp4"
    png  = "image/png"
    pdf  = "application/pdf"
    xls  = "application/vnd.ms-excel"
  }

}

resource "aws_s3_bucket" "b1" {
  #count = var.directory_bucket ? 0 : 1
  bucket = var.bucket_name
  #bucket_prefix = var.bucket_prefix  //for unique bucket_name
  force_destroy = var.destroy_bucket

  tags = {
    Name = var.bucket_tag_name
  }
}

resource "aws_s3_object" "ob" {
  bucket = aws_s3_bucket.b1.bucket
  source = var.s3_object_path
  key          = "${local.ct_value}-object"
  content_type = lookup(local.content_type, local.ct_value)
  server_side_encryption = var.sse_type
	//depends_on = [aws_s3_bucket_policy.s3_tf_policy]
}

resource "aws_s3_bucket_public_access_block" "exam" {
  bucket                  = aws_s3_bucket.b1.id
  block_public_acls       = var.s3_block_public_acls
  block_public_policy     = var.s3_block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.s3_restrict_public_buckets
}

resource "aws_s3_bucket_versioning" "bv" {
  bucket = aws_s3_bucket.b1.id
  versioning_configuration {
    status = var.enable_versioning
  }
}

resource "aws_s3_bucket_accelerate_configuration" "s1" {
  count  = var.accelerate ? 1 : 0
  bucket = aws_s3_bucket.b1.id
  status = "Enabled"
}

resource "aws_s3_bucket_ownership_controls" "s1" {
  count  = var.enable_acl ? 1 : 0
  bucket = aws_s3_bucket.b1.id
  rule {
    object_ownership = var.ownership_type
  }
}

resource "aws_s3_bucket_policy" "s3_tf_policy" {
  bucket = aws_s3_bucket.b1.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "Policy1234567890123",
    "Statement" : [
      {
        "Sid" : "Stmt1234567890123",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "s3:GetObject",
        "Resource" : [
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
      }
    ]
  })
}

resource "aws_s3_bucket_policy" "for_cf" {
	count      = var.with_cf ? 1 : 0
  bucket     = aws_s3_bucket.b1.id
  policy     = var.policy_for_cf
  depends_on = [var.cf_name]
}


resource "aws_s3_bucket_notification" "bn" {
	count = var.trigger_lambda == true ? 1 : 0
  bucket = aws_s3_bucket.b1.id
  lambda_function {
    lambda_function_arn = var.lf_arn
    //events = ["s3:ObjectCreated:*"]
		events = [var.lambda_trigger_event]
  }
	
	depends_on = [var.lf_permission]
}


resource "aws_s3_directory_bucket" "db" {
  count = var.directory_bucket ? 1 : 0
  bucket = "${var.bucket_name}--${var.az_id}--x-s3"
  location {
    name = var.region
  }
  //Bucket name must be in the following format
  //[bucket_name]--[azid]--x-s3
}

resource "aws_s3_bucket_website_configuration" "web" {
  count = var.as_website == true ? 1 : 0
  bucket = aws_s3_bucket.b1.id
  index_document {
    suffix = "index.html"
  }
}
*/
