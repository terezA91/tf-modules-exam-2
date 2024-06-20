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
  bucket = var.bucket_name
  #bucket_prefix = var.bucket_prefix  //for unique bucket_name
  force_destroy = var.destroy_bucket

  tags = {
    Name = var.bucket_tag_name
  }
}

resource "aws_s3_object" "ob" {
  bucket                 = aws_s3_bucket.b1.bucket
  source                 = var.s3_object_path
  key                    = "${local.ct_value}-object"
  content_type           = lookup(local.content_type, local.ct_value)
  server_side_encryption = var.sse_type
  depends_on             = [aws_s3_bucket.b1]
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

resource "null_resource" "wait_after_creating_policy" {
  depends_on = [aws_s3_bucket_policy.s3_tf_policy]
  provisioner "local-exec" {
    command = "sleep 30"
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
  //depends_on = [aws_s3_bucket.b1]
}

resource "aws_s3_bucket_policy" "for_cf" {
  count      = var.with_cf ? 1 : 0
  bucket     = aws_s3_bucket.b1.id
  policy     = var.policy_for_cf
  depends_on = [var.cf_name]
}
