
module "source_bucket" {
  providers = {
    aws = aws.me
  }

  source = "../../modules/s3"

  name = "file-stream-source-bucket"

}

module "destination_bucket" {
  providers = {
    aws = aws.me
  }

  source = "../../modules/s3"

  name = "file-stream-destination-bucket"

  enable_versioning = true

  enable_cors = true
}

data "aws_iam_policy_document" "media_convert_service_access" {
  provider = aws.me

  statement {
    sid    = "S3AccessSource"
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:List*",
      "s3:Describe*",
      "s3-object-lambda:Get*",
      "s3-object-lambda:List*"
    ]

    resources = [
      module.source_bucket.arn,
      "${module.source_bucket.arn}/*"
    ]
  }

  statement {
    sid    = "S3AccessDestination"
    effect = "Allow"
    actions = [
      "s3:*",
      "s3-object-lambda:*"
    ]

    resources = [
      module.destination_bucket.arn,
      "${module.destination_bucket.arn}/*"
    ]
  }
}

module "media_convert_role" {
  providers = {
    aws = aws.me
  }
  source = "../../modules/service_role"

  name = "MediaConvertRole"

  assume_role_principals = [
    "mediaconvert.amazonaws.com"
  ]

  inline_policies = {
    s3_access = data.aws_iam_policy_document.media_convert_service_access.json
  }
  attached_policies = [
    "arn:aws:iam::aws:policy/AmazonAPIGatewayInvokeFullAccess"
  ]
}

resource "aws_s3_bucket_policy" "allow_access_from_cdn" {
  bucket = module.destination_bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_cdn.json
}

data "aws_iam_policy_document" "allow_access_from_cdn" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      module.destination_bucket.arn,
      "${module.destination_bucket.arn}/*",
    ]

    condition {
      test = "StringLike"
      variable = "aws:SourceArn"

      values = [
        module.cloudfront_distribution.distribution_arn
      ]

    }
  }
}
