variable "LINODE_API_KEY" {
  description = "The key to the Linode API"
  type        = string
  sensitive   = true
}

variable "instance_region" {
  description = "The region to create the instance"
  type        = string
  default     = "us-south"
}

variable "instance_zone" {
  description = "The region to create the instance"
  type        = string
  default     = "us-south-3"
}

variable "instance_type" {
  description = "Which instance type to create"
  type    = string
  default = "bxf-2x8"
}

variable "domain_name" {
  description = "The domain to create instance records in."
  type    = string
  default = "siwko.org"
}

variable "domain_soa_email" {
  description = "The domain manager e-mail address."
  type    = string
  default = "asiwko@siwko.org"
}

variable "image_name" {
  description = "The image to use"
  type    = string
  default = "ibm-redhat-9-6-minimal-amd64-6"
}

