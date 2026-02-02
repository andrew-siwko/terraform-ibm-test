resource "ibm_is_security_group" "web_sg" {
  name = "web-server-sg"
  vpc  = ibm_is_vpc.asiwko-vpc.id
}




resource "ibm_is_security_group_rule" "inbound_rules" {
  for_each  = {
    ssh   = 22
    http  = 80
    https = 443
    app   = 8080
  }
  
  group     = ibm_is_security_group.web_sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  
  protocol = "tcp"
  port_min = each.value
  port_max = each.value
}