terraform {
  required_version = ">= 0.13.4"
  required_providers {
    cloudfoundry = {
      source  = "cloudfoundry-community/cloudfoundry"
      version = "0.12.6"
    }
  }

  backend "s3" {
    region = "eu-west-2"
    key = "store/terraform.tfstate"
  }

}