variable "oac_name" {
  type        = string
  description = "A name that identifies the Origin Access Control."
}

variable "distribution_origin_id" {
  type        = string
  description = "Unique identifier for the origin."
}

variable "distribution_origin_domain_name" {
  type        = string
  description = "DNS domain name of either the S3 bucket, or web site of your custom origin."
}
