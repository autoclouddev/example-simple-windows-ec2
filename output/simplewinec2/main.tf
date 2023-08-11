####
# An example raw header. Any text that is placed here will be inserted at the top of the main.tf file
# exactly as it is written. Authors must ensure that the content is valid Terraform code for their environment.

locals {
  account_num = data.aws_caller_identity.current.account_id
  win_sg_list = concat( module.wec2winsg-cll744b8k1787083qlt7jqfaq.win_sg_list, [ module.wec2sg-cll744b8k1787083qlt7jqfaq.sg_id ])
  module_tags = []
}

data "aws_caller_identity" "current" {}


# START AUTOCLOUD GENERATED CODE
# Results
# - Details: https://app.nonprod.autocloud.io/iac-catalog/cll744b8k1787083qlt7jqfaq?slug=example_simple_windows_ec_2_instance&versionId=preview 



module "wec2tags-cll744b8k1787083qlt7jqfaq" {
  source             = "git@github.com:autoclouddev/infrasturcture-modules-test.git//tags?ref=0.3.0"
  AppID              = 2468
  CRIS               = "Low"
  Compliance         = ["None"]
  DataClassification = "Internal"
  Environment        = "Dev"
  Notify             = ["notify@example.com"]
  Owner              = ["Tom", "Dick", "Harry"]
}

module "wec2vpcid-cll744b8k1787083qlt7jqfaq" {
  source  = "app.terraform.io/AutoCloud/utils/aws//modules/vpcid"
  version = "0.4.0"
  providers = {
    aws = aws.usw2
  }

  depends_on = [
    module.account_baseline # Force account baseline execution before creating keys
  ]

}

module "wec2amiid-cll744b8k1787083qlt7jqfaq" {
  source  = "app.terraform.io/AutoCloud/utils/aws//modules/golden-ami"
  version = "0.4.0"
  os      = "windows"
}

module "wec2winsg-cll744b8k1787083qlt7jqfaq" {
  source  = "app.terraform.io/AutoCloud/utils/aws//modules/windows-security-groups"
  version = "0.4.0"
}

module "wec2sg-cll744b8k1787083qlt7jqfaq" {
  source      = "git@github.com:autoclouddev/infrasturcture-modules-test.git//security-group?ref=0.3.0"
  tags        = module.wec2tags-cll744b8k1787083qlt7jqfaq.tags
  description = "Main security group for test-app-instance"
  name        = "test-app-instance-sg"
  vpc_id      = module.wec2vpcid-cll744b8k1787083qlt7jqfaq.vpc_id
}

module "wec2kms-cll744b8k1787083qlt7jqfaq" {
  source   = "git@github.com:autoclouddev/infrasturcture-modules-test.git//kms?ref=0.3.0"
  tags     = module.wec2tags-cll744b8k1787083qlt7jqfaq.tags
  aws_role = var.aws_role
  policy   = templatefile("${path.module}/templates/key_policy.json.tftpl", { account_num = local.account_num })
}

module "wec2instance-cll744b8k1787083qlt7jqfaq" {
  source                 = "git@github.com:autoclouddev/infrasturcture-modules-test.git//ec2/pge_windows?ref=0.3.1"
  tags                   = module.wec2tags-cll744b8k1787083qlt7jqfaq.tags
  ami                    = module.wec2amiid-cll744b8k1787083qlt7jqfaq.ami_id
  name                   = "test-app-instance"
  user_data              = <<EOT
<script>
echo Current date and time >> %SystemRoot%\Temp\test.log
echo %DATE% %TIME% >> %SystemRoot%\Temp\test.log
</script>

EOT
  vpc_security_group_ids = local.win_sg_list
}



# END AUTOCLOUD GENERATED CODE

####
# An example raw footer. Any text that is placed here will be inserted at the bottom of the main.tf file
# exactly as it is written. Authors must ensure that the content is valid Terraform code for their environment.
