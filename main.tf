resource "aws_transfer_server" "transfer_server" {
  identity_provider_type = "SERVICE_MANAGED"
  logging_role           = aws_iam_role.transfer_server_role.arn

  tags = {
    Name      = local.name-prefix
    Terraform = true
  }
}

resource "aws_transfer_user" "transfer_user_dev" {
  count          = length(var.transfer_server_user_name_dev)
  server_id      = aws_transfer_server.transfer_server.id
  user_name      = element(var.transfer_server_user_name_dev, count.index)
  role           = aws_iam_role.transfer_user_role_dev[0].arn
  home_directory = "/${var.s3_bucket_dev}"
}

resource "aws_transfer_ssh_key" "transfer_user_ssh_key_dev" {
  count     = length(var.transfer_server_user_name_dev)
  server_id = aws_transfer_server.transfer_server.id
  user_name = element(var.transfer_server_user_name_dev, count.index)
  body      = element(var.transfer_server_ssh_key_dev, count.index)

  depends_on = [
    aws_transfer_user.transfer_user_dev
  ]
}

resource "aws_transfer_user" "transfer_user_prod" {
  count          = length(var.transfer_server_user_name_prod)
  server_id      = aws_transfer_server.transfer_server.id
  user_name      = element(var.transfer_server_user_name_prod, count.index)
  role           = aws_iam_role.transfer_user_role_prod[0].arn
  home_directory = "/${var.s3_bucket_prod}"
}

resource "aws_transfer_ssh_key" "transfer_user_ssh_key_prod" {
  count     = length(var.transfer_server_user_name_prod)
  server_id = aws_transfer_server.transfer_server.id
  user_name = element(var.transfer_server_user_name_prod, count.index)
  body      = element(var.transfer_server_ssh_key_prod, count.index)

  depends_on = [
    aws_transfer_user.transfer_user_prod
  ]
}
