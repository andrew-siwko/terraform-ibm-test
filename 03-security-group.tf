resource "ibm_is_security_group" "asiwko_sg" {
  name = "asiwko-sg"
  vpc  = ibm_is_vpc.asiwko_vpc.id
}


resource "ibm_is_security_group_rule" "inbound_rules" {
  for_each  = {
    ssh   = 22
    http  = 80
    https = 443
    app   = 8080
  }
  
  group     = ibm_is_security_group.asiwko_sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  
  protocol = "tcp"
  port_min = each.value
  port_max = each.value
}

resource "ibm_is_security_group_rule" "outbound_rhel_activation" {
  group     = ibm_is_security_group.asiwko_sg.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
  protocol  = "tcp"
  port_min  = 80
  port_max  = 443 
}
resource "ibm_is_security_group_rule" "inbound_icmp" {
  group     = ibm_is_security_group.asiwko_sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  protocol  = "icmp"
  
  type = 8
  code = 0
}