resource "ibm_is_vpc" "asiwko-vpc" {
  name = "asiwko-vpc"
}

resource "ibm_is_subnet" "asiwko-subnet" {
  name            = "asiwko-subnet"
  vpc             = ibm_is_vpc.asiwko-vpc.id
  zone            = "us-south-1"
  ipv4_cidr_block = "10.240.0.0/24"
}
