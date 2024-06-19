output "bucket_id" {
  value = aws_s3_bucket.b1.id
}

output "bucket_arn" {
  value = aws_s3_bucket.b1.arn
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.b1.bucket
  description = "For referencing from cloudfront"
}

output "domain_name" {
  value       = aws_s3_bucket.b1.bucket_regional_domain_name
  description = "Domain name for referencing from cloudfront"
}

output "origin_id" {
  value       = aws_s3_bucket.b1.id //or_._.bucket
  description = "s3 bucket origin_id for referencing from cloudfront"
}

//Perhaps this could replace output "origin_id"
output "origin_bucket" {
  value = aws_s3_bucket.b1.bucket
}

