resource "ibm_is_vpc" "asiwko_vpc" {
  name = "asiwko-vpc"
}

resource "ibm_is_subnet" "asiwko_subnet_3" {
  name            = "asiwko-subnet-3"
  vpc             = ibm_is_vpc.asiwko_vpc.id
  zone            = "us-south-3"
  ipv4_cidr_block = "10.240.128.0/24"
}

resource "ibm_is_public_gateway" "asiwko_pgw_z3" {
  name = "asiwko-pgw-z3"
  vpc  = ibm_is_vpc.asiwko_vpc.id
  zone = "us-south-3"
}

resource "ibm_is_subnet_public_gateway_attachment" "asiwko_pgw_attach_z3" {
  subnet         = ibm_is_subnet.asiwko_subnet_3.id
  public_gateway = ibm_is_public_gateway.asiwko_pgw_z3.id
}
