resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = var.oac_name
  description                       = var.oac_desc
  origin_access_control_origin_type = var.origin_type
  signing_behavior                  = var.sign_behavior
  signing_protocol                  = var.sign_protocol
}

resource "aws_cloudfront_distribution" "cf" {
  /*
  depends_on = [
    var.origin_name,
    aws_cloudfront_origin_access_control.oac
  ]
*/
  origin {
    domain_name              = var.origin_domain_name
    origin_id                = var.cf_origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  enabled             = var.enable_cf_resource
  default_root_object = var.default_object
  wait_for_deployment = var.wait

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    cache_policy_id        = var.cache_pid
    target_origin_id       = var.cf_origin_id
    viewer_protocol_policy = var.viewer_protocol
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
      restriction_type = var.restriction_type
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = var.default_certificate
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
    sid    = var.iam_policy_sid
    effect = var.policy_effect
    actions = [
      var.policy_action
    ]

    principals {
      type        = var.principal_type
      identifiers = [var.principle_identity]
    }

    //resources = ["arn:aws:s3:::${var.origin_bucket}/*"]
    resources = ["${var.origin_arn}/*"]

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
  bucket     = var.cf_origin_id
  policy     = data.aws_iam_policy_document.iam-policy.json
}
*/
