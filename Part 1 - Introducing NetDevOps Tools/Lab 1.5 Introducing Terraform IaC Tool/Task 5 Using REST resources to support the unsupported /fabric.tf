resource "dcnm_rest" "dc1" {
    path    = "/appcenter/cisco/ndfc/api/v1/lan-fabric/rest/control/fabrics/DC1/Easy_Fabric"
    method  = "POST"
    payload = <<EOF
    {
        "BGP_AS": "65501",
        "DCI_SUBNET_RANGE": "10.234.0.0/16",
        "REPLICATION_MODE": "Ingress",
        "SUBNET_RANGE": "172.22.150.0/24",
        "LOOPBACK0_IP_RANGE": "10.11.0.0/16",
        "LOOPBACK1_IP_RANGE": "10.12.0.0/16",
        "DHCP_ENABLE": false,
        "ENABLE_PVLAN": "false",
        "ENABLE_PVLAN_PREV": "false"
    }
    EOF
}
