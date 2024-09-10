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

server_fabric_data = {

    SRV1 = {
        name = "podX-srv1"
        index = 1
        ens224 = "srv1"
    }

    SRV2 = {
        name = "podX-srv2"
        index = 2
        ens224 = "srv2"
    }

    SRV3 = {
        name = "podX-srv3"
        index = 3
        ens224 = "srv3" 
    }

    SRV4 = {
        name = "podX-srv4"
        index = 4
        ens224 = "srv4"
    }
}
