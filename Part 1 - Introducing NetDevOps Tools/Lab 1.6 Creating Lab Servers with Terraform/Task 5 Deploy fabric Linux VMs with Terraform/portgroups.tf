resource "vsphere_host_port_group" "dc1_oob_mgmt" {

  name                = format("(110%s) SDN_POD%s_DC1", var.pod, var.pod)
  host_system_id      = data.vsphere_host.esxi_host.id
  virtual_switch_name = "vSwitch0"

  vlan_id = format("110%s", var.pod)
  allow_promiscuous = true
  allow_forged_transmits = true
  allow_mac_changes = true
}

resource "vsphere_host_port_group" "dc2_oob_mgmt" {

    name                = format("(120%s) SDN_POD%s_DC2", var.pod, var.pod)
    host_system_id      = data.vsphere_host.esxi_host.id
    virtual_switch_name = "vSwitch0"

    vlan_id = format("120%s", var.pod)
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

data "vsphere_network" "dc1_oob_mgmt" {
  name          = format("(110%s) SDN_POD%s_DC1", var.pod, var.pod)
  datacenter_id = data.vsphere_datacenter.datacenter.id
  depends_on = [
    vsphere_host_port_group.dc1_oob_mgmt
  ]
}

data "vsphere_network" "dc2_oob_mgmt" {
  name          = format("(120%s) SDN_POD%s_DC2", var.pod, var.pod)
  datacenter_id = data.vsphere_datacenter.datacenter.id
  depends_on = [
    vsphere_host_port_group.dc2_oob_mgmt
  ]
}

data "vsphere_network" "srv11" {
  name          = format("(1%s11) SDN_POD%s_SRV11", var.pod, var.pod)
  datacenter_id = data.vsphere_datacenter.datacenter.id
  depends_on = [
    vsphere_host_port_group.srv11
  ]  
}

data "vsphere_network" "srv12" {
  name          = format("(1%s12) SDN_POD%s_SRV12", var.pod, var.pod)
  datacenter_id = data.vsphere_datacenter.datacenter.id
  depends_on = [
    vsphere_host_port_group.srv12
  ]    
}

# # Deploy vSwitch and its associated port-group

resource "vsphere_host_virtual_switch" "pod_vswitches" {

    for_each = var.portgroup_data

    name = format("vSwitch%s", replace(each.key, "X", var.pod)) 
    host_system_id      = data.vsphere_host.esxi_host.id
    mtu = 9000
    network_adapters = []
    active_nics = [] 
    standby_nics = []
}

resource "vsphere_host_port_group" "pod_portgroups" {

    for_each = var.portgroup_data

    name                = format("(%s) %s", replace(each.key, "X", var.pod), replace(each.value, "X", var.pod))
    host_system_id      = data.vsphere_host.esxi_host.id
    virtual_switch_name = format("vSwitch%s", replace(each.key, "X", var.pod)) 

    vlan_id = 4095
    allow_promiscuous = true
    allow_forged_transmits = true
    allow_mac_changes = true

    depends_on = [
    vsphere_host_virtual_switch.pod_vswitches
    ]
}

data "vsphere_network" "ports" {
  for_each = var.portgroup_data

  name = vsphere_host_port_group.pod_portgroups[each.key].name
  datacenter_id = data.vsphere_datacenter.datacenter.id
  depends_on = [
    vsphere_host_port_group.pod_portgroups
  ]
}