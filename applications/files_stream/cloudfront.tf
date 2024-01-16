
module "cloudfront_distribution" {
    providers = {
      aws = aws.me
    }
    source = "../../modules/cloudfront"
    distribution_origin_domain_name = module.destination_bucket.regional_domain_name
    distribution_origin_id = "file-stream"
    oac_name = "file-stream"
}

