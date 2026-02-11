# Andrew's Multicloud Terraform Experiment
## Goal
The goal of this repo is to create a usable VM in the IBM cloud.<br/>
Everything here was done using the IBM free trial.  <br/>
After this step completed I used Ansible to configure and install Tomcat and run a sample application.  [More on that later...](https://github.com/andrew-siwko/ansible-multi-cloud-tomcat-hello)<br/>
It all starts with the [Cloud Console](https://cloud.ibm.com).

## Multicloud
I tried to build the same basic structures in each of the cloud environments.  Each one starts with providers (and a backend), lays out the network and security, creates the VM and then registers the public IP in my DNS.  There is some variability which has been interesting to study.  The Terraform state file is stored on each provider.
* Step 1 - [AWS](https://github.com/andrew-siwko/terraform-aws-test)
* Step 2 - [Azure](https://github.com/andrew-siwko/terraform-azure-test)
* Step 3 - [GCP](https://github.com/andrew-siwko/terraform-gcp-test)
* Step 4 - [Linode](https://github.com/andrew-siwko/terraform-linode-test)
* Step 5 - [IBM](https://github.com/andrew-siwko/terraform-ibm-test) (you are here)
* Step 6 - [Oracle OCI](https://github.com/andrew-siwko/terraform-oracle-test) 

## Build Environment
I stood up my own Jenkins server and built a freestyle job to support the Terraform infrastructure builds.
* terraform init
* _some bash to import the domain (see below)_
* terraform plan
* terraform apply -auto-approve
* terraform output (This is piped to mail so I get an e-mail with the outputs.)

Yes, I know plan and apply should be separate and intentional.  In this case I found defects in plan which halted the job before apply.  That was useful.  I also commented out apply until plan was pretty close to working.<br/>
The Jenkins job contains environment variables with authentication information for the cloud environment and [Linode](https://www.linode.com/) (my registrar).<br/>
I did have a second job to import the domain zone but switched to a conditional in a script.  The code checks to see whether my zone record has been imported.  If not, the zone creation will fail.
```bash
if ! terraform state list | grep -q "linode_domain.dns_zone"; then
  echo "Resource not in state. Importing..."
  terraform import linode_domain.dns_zone 3417841
else
  echo "Domain already managed. Skipping import."
fi
```

## Observations
* IBM Cloud was my fifth target.  I had a little trouble setting up an account.  I got a live assist in real time to diagnose the problem.
* There were z/OS instances available in the cloud console.  How cool is that?
* I was not able to create and use a non-default VPC.  I spent several hours chasing this and finally decided to accept the default.
* Surprisingly, IBM (parent of Red Hat) did not have a RHEL 9.7 image.  All other providers (except Linode) did.  I ended up using a minimal RHEL 9.6.
* I had two challenges with the IBM Cloud
  * I could not find an availability zone to create my instance.  By trial and error, I went from south-1, to south-2, to south-3 where I finally was able to build.
  * Based on my experience with AWS, I created a non-default security group for the VPC to avoid the destroy lock.  This didn't work at IBM.  I had to pull the default security group from the VPC.  What I experiences was 10 minute hangs in the instance creation followed by: Can't start instance because provisioning failed. [more_info](https://cloud.ibm.com/docs/vpc?topic=vpc-instance-status-messages#cannot-start-compute)
* The admin user is root.  This felt normal.
* I was able to finish this project in one day.
* Project stats:
  * Start: 2026-02-02
  * Functional: 2026-02-02
  * Number of Jenkins builds to success: 51
  * Hurdles: 
    * Account creation (1 support ticket)
    * Finding a zone with capacity for my instance (trial and error)
    * non-default security group (my error)

