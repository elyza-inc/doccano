terraform {
  required_version = "0.13.0"

  backend "s3" {
    bucket               = "terraform-mhm"
    key                  = "mhm-doccano-stg.tfstate"
    region               = "us-east-1"
    workspace_key_prefix = "mhm-doccano-stg"
  }
}

provider "aws" {
  region = "us-east-2"
}

module "network" {
  source = "../modules/"

    doccano_ami_image_id = "ami-0eb8c19d230720e45"
    security_group_ssh = "sg-02f5d57837edc9637"
    security_group_public = "sg-00894cdead3385455"
    subnet_id = "subnet-0ef63e62b8d6f9950"
    route53_zone_id = "Z08812973255K2707O9RH"
    host            = "doccano.mhm-stg.elyza.ai"
}

