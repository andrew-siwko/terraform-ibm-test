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

resource "ibm_is_public_gateway" "asiwko_pgw_z1" {
  name = "asiwko-pgw-z1"
  vpc  = ibm_is_vpc.asiwko_vpc.id
  zone = "us-south-1"
}

resource "ibm_is_public_gateway" "asiwko_pgw_z2" {
  name = "asiwko-pgw-z2"
  vpc  = ibm_is_vpc.asiwko_vpc.id
  zone = "us-south-2"
}

resource "ibm_is_subnet_public_gateway_attachment" "asiwko_pgw_attach_z1" {
  subnet         = ibm_is_subnet.asiwko_subnet_1.id
  public_gateway = ibm_is_public_gateway.asiwko_pgw_z1.id
}
resource "ibm_is_subnet_public_gateway_attachment" "asiwko_pgw_attach_z2" {
  subnet         = ibm_is_subnet.asiwko_subnet_2.id
  public_gateway = ibm_is_public_gateway.asiwko_pgw_z2.id
}
