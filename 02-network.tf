resource "ibm_is_vpc" "asiwko_vpc" {
  name = "asiwko-vpc"
}

resource "ibm_is_subnet" "asiwko_subnet_1" {
  name            = "asiwko-subnet-1"
  vpc             = ibm_is_vpc.asiwko_vpc.id
  zone            = "us-south-1"
  ipv4_cidr_block = "10.240.0.0/24"
}
resource "ibm_is_subnet" "asiwko_subnet_2" {
  name            = "asiwko-subnet-2"
  vpc             = ibm_is_vpc.asiwko_vpc.id
  zone            = "us-south-2"
  ipv4_cidr_block = "10.240.64.0/24"
}
