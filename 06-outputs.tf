output "asiwko-vpc" {
  value = ibm_is_vpc.asiwko-vpc.*
}

output "asiwko-subnet" {
  value = ibm_is_subnet.asiwko-subnet.*
}

output "asiwko-vm-01" {
  value = ibm_is_instance.asiwko-vm-01.*
}

output "asiwko-public-ip" {
  value = ibm_is_floating_ip.asiwko_public_ip
}
