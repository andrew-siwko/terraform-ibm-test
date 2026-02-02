resource "ibm_is_ssh_key" "ssh_key" {
  name       = "terraform-ssh-key"
  public_key = file("/container_shared/ansible/ansible_rsa.pub")
}

resource "ibm_is_instance" "asiwko-vm-01" {
  name    = "rhel9-web-server"
  image   = "r006-74b862b7-5f73-4791-b371-3a05e55e0034" 
  profile = "cx2-2x4"
  
  primary_network_interface {
    subnet          = ibm_is_subnet.subnet.id
    security_groups = [ibm_is_security_group.web_sg.id]
  }

  vpc  = ibm_is_vpc.vpc.id
  zone = "us-south-1"
  keys = [ibm_is_ssh_key.ssh_key.id]
}

