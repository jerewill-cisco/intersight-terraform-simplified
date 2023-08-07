terraform {
  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = ">= 1.0.37"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}

provider "intersight" {
  apikey    = var.intersight-keyid
  secretkey = var.intersight-secretkey
  endpoint  = "https://intersight.com"
}

provider "random" {
}
