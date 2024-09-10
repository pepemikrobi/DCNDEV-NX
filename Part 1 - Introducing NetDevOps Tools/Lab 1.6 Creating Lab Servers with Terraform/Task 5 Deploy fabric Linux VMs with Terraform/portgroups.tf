resource "vsphere_host_port_group" "dc1_oob_mgmt" {

    name                = format("(110%s) SDN_POD%s_DC1", var.pod, var.pod)
    host_system_id      = data.vsphere_host.esxi_host.id
    virtual_switch_name = "vSwitch0"

    vlan_id = format("110%s", var.pod)
    allow_promiscuous = true
    allow_forged_transmits = true
    allow_mac_changes = true
}

resource "vsphere_host_port_group" "srv11" {

    name                = format("(1%s11) SDN_POD%s_SRV11", var.pod, var.pod)
    host_system_id      = data.vsphere_host.esxi_host.id
    virtual_switch_name = "vSwitch1"

    vlan_id = format("1%s11", var.pod)
    allow_promiscuous = true
    allow_forged_transmits = true
    allow_mac_changes = true
}

resource "vsphere_host_port_group" "srv12" {

    name                = format("(1%s12) SDN_POD%s_SRV12", var.pod, var.pod)
    host_system_id      = data.vsphere_host.esxi_host.id
    virtual_switch_name = "vSwitch1"

    vlan_id = format("1%s12", var.pod)
    allow_promiscuous = true
    allow_forged_transmits = true
    allow_mac_changes = true
}

# SRV1-4

resource "vsphere_host_port_group" "srv1" {

    name                = format("(1%s01) SDN_POD%s_SRV1", var.pod, var.pod)
    host_system_id      = data.vsphere_host.esxi_host.id
    virtual_switch_name = "vSwitch0"

    vlan_id = format("1%s01", var.pod)
    allow_promiscuous = true
    allow_forged_transmits = true
    allow_mac_changes = true
}

resource "vsphere_host_port_group" "srv2" {

    name                = format("(1%s02) SDN_POD%s_SRV2", var.pod, var.pod)
    host_system_id      = data.vsphere_host.esxi_host.id
    virtual_switch_name = "vSwitch0"

    vlan_id = format("1%s02", var.pod)
    allow_promiscuous = true
    allow_forged_transmits = true
    allow_mac_changes = true
}

resource "vsphere_host_port_group" "srv3" {

    name                = format("(1%s03) SDN_POD%s_SRV3", var.pod, var.pod)
    host_system_id      = data.vsphere_host.esxi_host.id
    virtual_switch_name = "vSwitch0"

    vlan_id = format("1%s03", var.pod)
    allow_promiscuous = true
    allow_forged_transmits = true
    allow_mac_changes = true
}

resource "vsphere_host_port_group" "srv4" {

    name                = format("(1%s04) SDN_POD%s_SRV4", var.pod, var.pod)
    host_system_id      = data.vsphere_host.esxi_host.id
    virtual_switch_name = "vSwitch0"

    vlan_id = format("1%s04", var.pod)
    allow_promiscuous = true
    allow_forged_transmits = true
    allow_mac_changes = true
}


data "vsphere_network" "oob_mgmt" {
    name          = format("(110%s) SDN_POD%s_DC1", var.pod, var.pod)
    datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "srv11" {
    name          = format("(1%s11) SDN_POD%s_SRV11", var.pod, var.pod)
    datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "srv12" {
    name          = format("(1%s12) SDN_POD%s_SRV12", var.pod, var.pod)
    datacenter_id = data.vsphere_datacenter.datacenter.id
}

# SRV1-4
data "vsphere_network" "srv1" {
    name          = format("(1%s01) SDN_POD%s_SRV1", var.pod, var.pod)
    datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "srv2" {
    name          = format("(1%s02) SDN_POD%s_SRV2", var.pod, var.pod)
    datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "srv3" {
    name          = format("(1%s03) SDN_POD%s_SRV3", var.pod, var.pod)
    datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "srv4" {
    name          = format("(1%s04) SDN_POD%s_SRV4", var.pod, var.pod)
    datacenter_id = data.vsphere_datacenter.datacenter.id
}
