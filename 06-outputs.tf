output "network_info" {
  value = google_compute_network.vpc_network.*
}

output "public_ip" {
  value = google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip
}

output  "asiwko-vpc" {
  value= ibm_is_vpc.asiwko-vpc.*
}

output "asiwko-subnet"{
  value= ibm_is_subnet.asiwko-subnet.*
}

output "asiwko-vm-01" {
  value=ibm_is_instance.asiwko-vm-01.*
}