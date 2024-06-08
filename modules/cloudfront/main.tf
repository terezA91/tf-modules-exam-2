resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "Some name of cf OAC"
  description                       = "cf OAC for access to non-public s3 origin"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "cf" {
/*
  depends_on = [
    var.s3_bucket_name,
    aws_cloudfront_origin_access_control.oac
  ]
*/
  origin {
    domain_name              = var.origin_domain_name
    origin_id                = var.origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  enabled             = true
  default_root_object = "index.html"
  wait_for_deployment = true

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    cache_policy_id        = var.cache_pid
    target_origin_id       = var.origin_id
    viewer_protocol_policy = "https-only" //or <allow-all>
/*
    This is alternative of the argument <cache_policy_id>
		forwarded_values {
			query_string = false

			cookies {
				forward = "none"
			}
		}
*/
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

data "aws_iam_policy_document" "iam-policy" {
/*
  depends_on = [
    var.s3_bucket_name,
    aws_cloudfront_distribution.cf
  ]
*/
  statement {
    sid    = "PolicyForCfToS3"
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    //resources = ["arn:aws:s3:::${var.origin_bucket}/*"]
    resources = ["${var.s3_bucket_arn}/*"]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.cf.arn]
    }
  }
}

/*
resource "aws_s3_bucket_policy" "s3-policy" {
  depends_on = [aws_cloudfront_distribution.cf]
  bucket     = var.origin_id
  policy     = data.aws_iam_policy_document.iam-policy.json
}
*/
