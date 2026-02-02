terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.53.0"
    }
  }
  backend "s3" {
    bucket                      = "siwko-terraform-state-lts"
    key                         = "ibm-vsi/terraform.tfstate"
    region                      = "us-south"
    endpoints = {
      s3 = "https://s3.us-south.cloud-object-storage.appdomain.cloud"
    }

    # MANDATORY for IBM COS / S3-compatible backends:
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    
    # These should stay as previously configured:
    use_path_style              = true
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}

provider "ibm" {
  region = "us-south"
}

variable "LINODE_API_KEY" {
  description = "The key to the Linode API"
  type        = string
}

provider "linode" {
  token = var.LINODE_API_KEY
}
