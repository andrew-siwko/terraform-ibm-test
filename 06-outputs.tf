output "asiwko-vpc" {
  value = ibm_is_vpc.asiwko_vpc.*
}

output "asiwko-subnet-1" {
  value = ibm_is_subnet.asiwko_subnet_1.*
}
output "asiwko-subnet-2" {
  value = ibm_is_subnet.asiwko_subnet_2.*
}

output "asiwko-vm-01" {
  value = ibm_is_instance.asiwko-vm-01.*
}

output "asiwko-public-ip" {
  value = ibm_is_floating_ip.asiwko_public_ip.address
}
