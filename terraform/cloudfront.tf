module "cdn" {
  source = "terraform-aws-modules/cloudfront/aws"

  comment             = "IO.finnet CloudFront"
  enabled             = true
  is_ipv6_enabled     = false
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  wait_for_deployment = false

  create_origin_access_identity = true
  origin_access_identities = {
    s3_bucket_auth      = "My awesome CloudFront can access"
    s3_bucket_info      = "My awesome CloudFront can access"
    s3_bucket_customers = "My awesome CloudFront can access"
  }

  #   logging_config = {
  #     bucket = "io-finnet-cdn-logs.s3.amazonaws.com"
  #   }

  origin = {

    auth = {
      domain_name = module.s3_bucket["auth"].s3_bucket_bucket_domain_name
      s3_origin_config = {
        origin_access_identity = "s3_bucket_auth"
      }
    }
    info = {
      domain_name = "${var.env}-info-io-finnet-bucket.s3.amazonaws.com"
      s3_origin_config = {
        origin_access_identity = "s3_bucket_info"
      }
    }
    customers = {
      domain_name = "${var.env}-customers-io-finnet-bucket.s3.amazonaws.com"
      s3_origin_config = {
        origin_access_identity = "s3_bucket_customers"
      }
    }
  }

  default_cache_behavior = {
    target_origin_id       = "something"
    viewer_protocol_policy = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }

  ordered_cache_behavior = [
    {
      path_pattern           = "/auth/*"
      target_origin_id       = "auth"
      viewer_protocol_policy = "redirect-to-https"

      allowed_methods = ["GET", "HEAD", "OPTIONS"]
      cached_methods  = ["GET", "HEAD"]
      compress        = true
      query_string    = true
    },
    {
      path_pattern           = "/info/*"
      target_origin_id       = "info"
      viewer_protocol_policy = "redirect-to-https"

      allowed_methods = ["GET", "HEAD", "OPTIONS"]
      cached_methods  = ["GET", "HEAD"]
      compress        = true
      query_string    = true
    },
    {
      path_pattern           = "/customers/*"
      target_origin_id       = "customers"
      viewer_protocol_policy = "redirect-to-https"

      allowed_methods = ["GET", "HEAD", "OPTIONS"]
      cached_methods  = ["GET", "HEAD"]
      compress        = true
      query_string    = true
    }
  ]

  #   viewer_certificate = {
  #     acm_certificate_arn = "arn:aws:acm:us-east-1:135367859851:certificate/1032b155-22da-4ae0-9f69-e206f825458b"
  #     ssl_support_method  = "sni-only"
  # #     cloudfront_default_certificate = true
  #   }
}
