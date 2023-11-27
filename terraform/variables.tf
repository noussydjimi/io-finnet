######################
## GLOBAL VARIABLES ##
######################

variable "aws_region" {
  type        = string
  description = "The AWS region."
  default     = "eu-north-1"
}

variable "aws_account_id" {
  type        = string
  description = "The AWS account id."
  default     = null
}

variable "aws_profile" {
  type        = string
  description = "The AWS profile."
  default     = "io-finnet"
}

variable "env" {
  type        = string
  description = "The environment"
  default     = "dev"
}

variable "cloudfront_distrubution" {
  type        = set(string)
  description = "The cloudfront distribution"
  default = [
    "auth",
    "info",
    "customers"
  ]
}

# variable "tags" {
#   type = map
#   description = ""
#   value = {
#     Environment = "dev"
#     provisionner = "Terraform"
#   }
# }

