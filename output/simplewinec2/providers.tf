provider "aws" {
  region = var.aws_region
  # The following code is for using cross account assume role
  assume_role {
    role_arn = "arn:aws:iam::${var.account_num}:role/${var.aws_role}"
  }
}
