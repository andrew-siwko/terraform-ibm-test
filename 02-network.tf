resource "ibm_is_vpc" "asiwko-vpc" {
  name = "terraform-vpc"
}

resource "ibm_is_subnet" "asiwko-subnet" {
  name            = "terraform-subnet"
  vpc             = ibm_is_vpc.asiwko-vpc.id
  zone            = "us-south-1"
  ipv4_cidr_block = "10.240.0.0/24"
}
