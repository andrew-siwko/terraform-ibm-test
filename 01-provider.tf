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
    endpoint                    = "s3.us-south.cloud-object-storage.appdomain.cloud"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
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
