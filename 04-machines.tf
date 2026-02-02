resource "time_sleep" "wait_for_networking" {
  depends_on = [
    ibm_is_subnet.asiwko_subnet_2,
    ibm_is_security_group_rule.outbound_rhel_activation
  ]

  create_duration = "60s"
}

resource "ibm_is_ssh_key" "ssh_key" {
  name       = "asiwko-ssh-key"
  public_key = file("/container_shared/ansible/ansible_rsa.pub")
}

data "ibm_is_image" "rhel9_image" {
  name = "ibm-redhat-9-6-minimal-amd64-6" 
}

resource "ibm_is_instance" "asiwko-vm-01" {
  name  = "asiwko-vm-01"
  image = data.ibm_is_image.rhel9_image.id
  # profile = "cx2-2x4"
  profile = "bxf-2x8"
  metadata_service {
    enabled            = true
    protocol           = "http"
    response_hop_limit = 1
  }  
  depends_on = [time_sleep.wait_for_networking]
  primary_network_interface {
    name            = "asiwko-vm-01-nic"
    subnet          = ibm_is_subnet.asiwko_subnet_2.id
    security_groups = [ibm_is_security_group.asiwko_sg.id]
  }

  vpc  = ibm_is_vpc.asiwko_vpc.id
  zone = "us-south-2"
  keys = [ibm_is_ssh_key.ssh_key.id]
}

resource "ibm_is_floating_ip" "asiwko_public_ip" {
  name       = "asiwko-vm-01-fip"
  target     = ibm_is_instance.asiwko-vm-01.primary_network_interface[0].id
  depends_on = [ibm_is_instance.asiwko-vm-01]
}
