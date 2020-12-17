terraform {
  required_version = "0.13.0"

  backend "s3" {
    bucket               = "terraform-mhm-elyza"
    key                  = "mhm-doccano-prod.tfstate"
    region               = "ap-northeast-1"
    workspace_key_prefix = "mhm-doccano-prod"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

module "network" {
  source = "../modules/"

    doccano_ami_image_id = "ami-0138b0377629e9db8"
    security_group_ssh = "sg-0505616294c9dc143"
    security_group_public = "sg-0e105820ae17ec3fc"
    subnet_id = "subnet-047c69903ed814d44"
    route53_zone_id = "Z08912512HZIVVN7EBISE"
    host            = "doccano.mhm.elyza.ai"
}

