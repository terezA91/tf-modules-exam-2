provider "aws" {
	region = "eu-north-1"
	profile = "default"
}

resource "aws_s3_bucket" "b1" {
	#count = var.directory_bucket ? 0 : 1
	bucket = var.bucket_name
	#bucket_prefix = "helma"  //for unique bucket_name
	force_destroy = var.destroy_bucket
	
	tags = {
		Name = "Custom bucket"
	}
}

resource "aws_s3_object" "ob" {
  bucket = aws_s3_bucket.b1.bucket
  source = "${path.module}/${var.object_source}"
  key = var.object_name
	content_type = var.as_website == true ? "text/html" : "image/jpeg"
	server_side_encryption = "AES256"
}

resource "aws_s3_bucket_public_access_block" "exam" {
	bucket = aws_s3_bucket.b1.id
	block_public_acls = var.s3_block_public_acls
	block_public_policy = var.s3_block_public_policy
	ignore_public_acls = var.ignore_public_acls
	restrict_public_buckets = var.s3_restrict_public_buckets
}

resource "aws_s3_bucket_versioning" "bv" {
	bucket = aws_s3_bucket.b1.id
	versioning_configuration {
		status = var.enable_versioning[0]
	}
}

resource "aws_s3_bucket_accelerate_configuration" "s1" {
	count = var.accelerate ? 1 : 0
  bucket = aws_s3_bucket.b1.id
  status = "Enabled"
}

resource "aws_s3_bucket_ownership_controls" "s1" {
	count = var.enable_acl ? 1 : 0
  bucket = aws_s3_bucket.b1.id
  rule {
    object_ownership = "BucketOwnerPreferred"
    #object_ownership = "ObjectWriter"
  }
}

/*
resource "aws_s3_bucket_notification" "bn" {
	count = var.trigger_lambda == true ? 1 : 0
  bucket = aws_s3_bucket.b1.id

  lambda_function {
    lambda_function_arn = var.lf_arn
    events = ["s3:ObjectCreated:*"]
  }
	
	depends_on = [var.lf_permission]
}

/*
resource "aws_s3_bucket_policy" "s3-policy" {
  bucket     = aws_s3_bucket.b1.id
  policy     = var.policy_for_cf
  depends_on = [var.cf_name]
}


resource "aws_s3_directory_bucket" "db" {
  count = var.directory_bucket ? 1 : 0
  bucket = "${var.bucket_name}--usw2-az1--x-s3"
  location {
    name = "eu-north-1"
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
