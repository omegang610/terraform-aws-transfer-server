data "aws_iam_policy_document" "transfer_server_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["transfer.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "transfer_server_to_cloudwatch_assume_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }
}

data "template_file" "transfer_user_policy_dev" {
  count    = local.dev_enabled
  template = "${file("${path.module}/templates/sftp-user-dev.json.tpl")}"
  vars = {
    transfer_bucket_arn = data.aws_s3_bucket.s3_bucket_dev[count.index].arn
  }
}

data "template_file" "transfer_user_policy_prod" {
  count    = local.prod_enabled
  template = "${file("${path.module}/templates/sftp-user-prod.json.tpl")}"
  vars = {
    transfer_bucket_arn = data.aws_s3_bucket.s3_bucket_prod[count.index].arn
  }
}

resource "aws_iam_role" "transfer_server_role" {
  name               = "${local.name-prefix}_server_role"
  assume_role_policy = data.aws_iam_policy_document.transfer_server_assume_role.json
}

resource "aws_iam_role_policy" "transfer_server_to_cloudwatch_policy" {
  name   = "${local.name-prefix}_server_to_cloudwatch_policy"
  role   = aws_iam_role.transfer_server_role.name
  policy = data.aws_iam_policy_document.transfer_server_to_cloudwatch_assume_policy.json
}

resource "aws_iam_role" "transfer_user_role_dev" {
  count              = local.dev_enabled
  name               = "${local.name-prefix}-user_role_dev"
  assume_role_policy = data.aws_iam_policy_document.transfer_server_assume_role.json
}

resource "aws_iam_policy" "transfer_user_policy_dev" {
  count       = local.dev_enabled
  name_prefix = "${local.name-prefix}_user_policy_dev"
  description = "sftp user's policy, write on input folder and read on output folder"
  policy      = data.template_file.transfer_user_policy_dev[count.index].rendered
}

resource "aws_iam_role_policy_attachment" "transfer_user_policy_attachment_dev" {
  count      = local.dev_enabled
  role       = aws_iam_role.transfer_user_role_dev[count.index].name
  policy_arn = aws_iam_policy.transfer_user_policy_dev[count.index].arn
}

resource "aws_iam_role" "transfer_user_role_prod" {
  count              = local.prod_enabled
  name               = "${local.name-prefix}-user_role_prod"
  assume_role_policy = data.aws_iam_policy_document.transfer_server_assume_role.json
}

resource "aws_iam_policy" "transfer_user_policy_prod" {
  count       = local.prod_enabled
  name_prefix = "${local.name-prefix}_user_policy_prod"
  description = "sftp user's policy, write on input folder and read on output folder"
  policy      = data.template_file.transfer_user_policy_prod[count.index].rendered
}

resource "aws_iam_role_policy_attachment" "transfer_user_policy_attachment_prod" {
  count      = local.prod_enabled
  role       = aws_iam_role.transfer_user_role_prod[count.index].name
  policy_arn = aws_iam_policy.transfer_user_policy_prod[count.index].arn
}
