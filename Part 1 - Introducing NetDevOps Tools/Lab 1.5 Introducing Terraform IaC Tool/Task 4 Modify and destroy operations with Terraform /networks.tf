resource "dcnm_network" "network_1" {
    fabric_name     = "DC1"
    name            = "Network1"
    network_id      = "1001"
    display_name    = "Network1"
    description     = "The first network from terraform"
    l2_only_flag    = true
    ir_enable_flag  = true
    deploy          = false   
}

resource "dcnm_network" "network_2" {
    fabric_name     = "DC1"
    name            = "Network2"
    network_id      = "1002"
    display_name    = "Network2"
    description     = "The second network from terraform"
    l2_only_flag    = true
    ir_enable_flag  = true    
    deploy          = false   
}

resource "dcnm_network" "network_3" {
    fabric_name     = "DC1"
    name            = "Network31"
    network_id      = "1003"
    display_name    = "Network31"
    description     = "The third network from terraform"
    l2_only_flag    = true
    ir_enable_flag  = true    
    deploy          = false   
}
