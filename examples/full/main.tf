module "sftp" {
  source = "../../"

  project = "my-project"
  s3_bucket_dev = "sftp-example-bucket-dev"

  transfer_server_user_name_dev = [
    "Chris-dev",
    "Mary-dev"
  ]

  transfer_server_ssh_key_dev = [
    "ssh-rsa AAAAB3NAAAAAAAA",
    "ssh-rsa AAAAB3NBBBBBBBB"
  ]

  s3_bucket_prod = "sftp-example-bucket-prod"

  transfer_server_user_name_prod = [
    "Chris-prod"
  ]

  transfer_server_ssh_key_prod = [
    "ssh-rsa AAAAB3NAAAAAAAA"
  ]

}
