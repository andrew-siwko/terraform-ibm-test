resource "ibm_is_ssh_key" "ssh_key" {
  name       = "terraform-ssh-key"
  public_key = file("/container_shared/ansible/ansible_rsa.pub")
}

data "ibm_is_image" "rhel9_image" {
  name = "bm-redhat-9-6-minimal-amd64-6" #
}

resource "ibm_is_instance" "asiwko-vm-01" {
  name    = "asiwko-vm-01"
  image   = data.ibm_is_image.rhel9_image.id
  profile = "cx2-2x4"
  
  primary_network_interface {
    subnet          = ibm_is_subnet.asiwko_subnet.id
    security_groups = [ibm_is_security_group.asiwko_sg.id]
  }

  vpc  = ibm_is_vpc.asiwko_vpc.id
  zone = "us-south-1"
  keys = [ibm_is_ssh_key.ssh_key.id]
}

