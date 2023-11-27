module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "v3.15.1"

  for_each = var.cloudfront_distrubution

  bucket = "${var.env}-${each.key}-io-finnet-bucket"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}
