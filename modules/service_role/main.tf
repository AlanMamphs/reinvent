data "aws_iam_policy_document" "service_grant" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "Service"
      identifiers = var.assume_role_principals
    }
  }
}

resource "aws_iam_role" "this" {
  name        = var.name
  description = var.description

  assume_role_policy = data.aws_iam_policy_document.service_grant.json
}


resource "aws_iam_role_policy_attachment" "this" {
  for_each   = var.attached_policies
  role       = aws_iam_role.this.id
  policy_arn = each.value
}

resource "aws_iam_role_policy" "this" {
  for_each    = var.inline_policies
  name_prefix = "${each.key}-"
  role        = aws_iam_role.this.id
  policy      = each.value
}
