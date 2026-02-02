resource "ibm_is_vpc" "asiwko-vpc" {
  name = "terraform-vpc"
}

# 3. Define a Subnet
resource "ibm_is_subnet" "subnet" {
  name            = "terraform-subnet"
  vpc             = ibm_is_vpc.vpc.id
  zone            = "us-south-1"
  ipv4_cidr_block = "10.240.0.0/24"
}
