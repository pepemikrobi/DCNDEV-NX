vcsa_hostname = "vcenter.sdn.lab"
vcsa_username = "podX-admin@hector.lan"
esxi_hostname = "podX-esxY.sdn.lab"
esxi_datastore = "podX-esxY-ds1-new"

pod = X

server_data = {

    SRV11 = {
        name = "podX-srv11"
        index = 18
        ens224 = "srv11"
    }
    SRV12 = {
        name = "podX-srv12"
        index = 19
        ens224 = "srv12"
    }
}

portgroup_data = {
    # Farbic server connections
    "2X31" = "PODX_SRV1_LEAF11"
    "2X32" = "PODX_SRV2_LEAF12"
    "2X41" = "PODX_SRV3_LEAF21"
    "2X42" = "PODX_SRV4_LEAF22"   

    # DC1
    "2X11" = "PODX_SPINE11_LEAF11"
    "2X12" = "PODX_SPINE11_LEAF12"
    "2X13" = "PODX_SPINE12_LEAF11"
    "2X14" = "PODX_SPINE12_LEAF12"

    # DC2
    "2X21" = "PODX_SPINE21_LEAF21"
    "2X22" = "PODX_SPINE21_LEAF22"
    "2X23" = "PODX_SPINE22_LEAF21"
    "2X24" = "PODX_SPINE22_LEAF22"

    # DCI
    "2X01" = "PODX_SPINE11_SPINE12"
    "2X02" = "PODX_SPINE21_SPINE22"
    "2X03" = "PODX_SPINE11_SPINE21"
    "2X04" = "PODX_SPINE12_SPINE22"

    # Leaf unused connections
    "2X33" = "PODX_LEAF11_UNUSED"
    "2X34" = "PODX_LEAF12_UNUSED"
    "2X43" = "PODX_LEAF21_UNUSED"
    "2X44" = "PODX_LEAF22_UNUSED"
}

server_fabric_data = {
    SRV1 = {
        name = "podX-srv1"
        index = 1
        ens224 = "2X31"
    }

    SRV2 = {
        name = "podX-srv2"
        index = 2
        ens224 = "2X32"
    }

    SRV3 = {
        name = "podX-srv3"
        index = 3
        ens224 = "2X41" 
    }

    SRV4 = {
        name = "podX-srv4"
        index = 4
        ens224 = "2X42"
    }
}

dc1_switch_data = {

  LEAF11 = {
    name = "PODX_LEAF11"
    index = 11
    serial_port = "2X11"
    eth1 = "2X11"
    eth2 = "2X13"
    eth3 = "2X31"
    eth4 = "2X33"
  }
  LEAF12 = {
    name = "PODX_LEAF12"
    index = 12
    serial_port = "2X12"
    eth1 = "2X12"
    eth2 = "2X14"
    eth3 = "2X32"
    eth4 = "2X34"
  }
  SPINE11 = {
    name = "PODX_SPINE11"
    index = 13
    serial_port = "2X13"
    eth1 = "2X11"
    eth2 = "2X12"
    eth3 = "2X01"
    eth4 = "2X03"
  }
  SPINE12 = {
    name = "PODX_SPINE12"
    index = 14
    serial_port = "2X14"
    eth1 = "2X13"
    eth2 = "2X14"
    eth3 = "2X01"
    eth4 = "2X04"
  }
}

dc2_switch_data = {

  LEAF21 = {
    name = "PODX_LEAF21"
    index = 21
    serial_port = "2X21"
    eth1 = "2X21"
    eth2 = "2X23"
    eth3 = "2X41"
    eth4 = "2X43"
  }
  LEAF22 = {
    name = "PODX_LEAF22"
    index = 22
    serial_port = "2X22"
    eth1 = "2X22"
    eth2 = "2X24"
    eth3 = "2X42"
    eth4 = "2X44"
  }
  SPINE21 = {
    name = "PODX_SPINE21"
    index = 23
    serial_port = "2X23"
    eth1 = "2X21"
    eth2 = "2X22"
    eth3 = "2X02"
    eth4 = "2X03"
  }
  SPINE22 = {
    name = "PODX_SPINE22"
    index = 24
    serial_port = "2X24"
    eth1 = "2X23"
    eth2 = "2X24"
    eth3 = "2X02"
    eth4 = "2X04"
  }
}