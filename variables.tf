variable "project" {
  description = "project name"
  type        = string
  default     = "your_project_name"
}

variable "application" {
  description = "project name"
  type        = string
  default     = "sftp"
}

variable "s3_bucket_dev" {
  description = "s3 bucket name for dev"
  type        = string
  default     = ""
}

variable "transfer_server_user_name_dev" {
  description = "User name for SFTP server"
  type        = list(string)
  default     = []
}

variable "transfer_server_ssh_key_dev" {
  description = "SSH publish key for transfer server user"
  type        = list(string)
  default     = []
}

variable "s3_bucket_prod" {
  description = "s3 bucket name for prod"
  type        = string
  default     = ""
}

variable "transfer_server_user_name_prod" {
  description = "User name for SFTP server"
  type        = list(string)
  default     = []
}

variable "transfer_server_ssh_key_prod" {
  description = "SSH publish key for transfer server user"
  type        = list(string)
  default     = []
}

data "aws_s3_bucket" "s3_bucket_dev" {
  count  = local.dev_enabled
  bucket = var.s3_bucket_dev
}

data "aws_s3_bucket" "s3_bucket_prod" {
  count  = local.prod_enabled
  bucket = var.s3_bucket_prod
}

locals {
  # Used for aws resource names.
  name-prefix  = "${var.project}-${var.application}"
  dev_enabled  = length(var.s3_bucket_dev) == 0 ? 0 : 1
  prod_enabled = length(var.s3_bucket_prod) == 0 ? 0 : 1
}
