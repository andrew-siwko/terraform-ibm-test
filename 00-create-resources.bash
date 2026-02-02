#!/bin/bash

# install the IBM Cloud CLI:
# https://cloud.ibm.com/docs/cli?topic=cli-install-ibmcloud-cli
#ibmcloud login
ibmcloud plugin install cloud-object-storage

ibmcloud resource groups
ibmcloud target -g Default
# Create the instance
ibmcloud resource service-instance-create my-terraform-cos cloud-object-storage standard global

# Capture the GUID (you'll need this for the next steps)
COS_GUID=$(ibmcloud resource service-instance my-terraform-cos --output json | jq -r '.[0].guid')

# Set the CRN in your local config
COS_CRN=$(ibmcloud resource service-instance my-terraform-cos --output json | jq -r '.[0].id')
ibmcloud cos config crn --crn $COS_CRN

# Create the bucket (must be a globally unique name)
ibmcloud cos bucket-create --bucket siwko-terraform-state --class standard --region us-south

# Create the key with HMAC enabled
ibmcloud resource service-key-create terraform-cos-key Manager --instance-name my-terraform-cos --parameters '{"HMAC":true}'

# View the credentials
ibmcloud resource service-key terraform-cos-key

# at this point, set up jenkins with the environment variables for access.
# COS_ACCESS_KEY
# COS_ACCESS_SECRET
