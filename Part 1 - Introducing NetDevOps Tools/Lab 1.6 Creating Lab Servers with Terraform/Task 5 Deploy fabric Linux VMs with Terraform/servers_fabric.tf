data "vsphere_virtual_machine" "server_fabric_template" {
    name          = format("pod%s_ubuntu", var.pod)
    datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "server_fabric" {

    for_each = var.server_fabric_data

    name                       = format("POD%s_%s", var.pod, each.key)
    resource_pool_id           = data.vsphere_resource_pool.pool.id
    datastore_id               = data.vsphere_datastore.datastore.id
    host_system_id             = data.vsphere_host.esxi_host.id
    wait_for_guest_net_timeout = 0
    wait_for_guest_ip_timeout  = 0
    num_cpus                   = 1
    memory                     = 2048
    guest_id                   = "ubuntu64Guest"
    boot_delay                 = 2000
    
    clone {
        template_uuid = "${data.vsphere_virtual_machine.server_fabric_template.id}"
        customize {
            dns_suffix_list = ["sdn.lab"]
            dns_server_list = ["10.16.2.3", "10.16.2.6"]
            linux_options {
                host_name = replace(each.value["name"], "X", var.pod)
                domain    = "sdn.lab"
            }
            network_interface {
                ipv4_address = format("10.11.10%s.%s", var.pod, each.value["index"])
                ipv4_netmask = 24
            }
            network_interface {
                ipv4_address = format("10.1%s.191.%s", var.pod, each.value["index"])
                ipv4_netmask = 24
            }
            ipv4_gateway = format("10.11.10%s.254", var.pod)
        }
    }

    disk {
        label            = "disk0"
        size             = data.vsphere_virtual_machine.server_fabric_template.disks.0.size
        thin_provisioned = data.vsphere_virtual_machine.server_fabric_template.disks.0.thin_provisioned
    }

    # ens160
    network_interface {
        network_id   = data.vsphere_network.dc1_oob_mgmt.id
        adapter_type = data.vsphere_virtual_machine.server_fabric_template.network_interface_types[0]
        use_static_mac = true
        mac_address  = format("02:ca:fe:0%s:%02s:00", var.pod, each.value["index"])
    }

    # ens224
    network_interface {
        network_id   = data.vsphere_network.ports[each.value["ens224"]].id
        adapter_type = data.vsphere_virtual_machine.server_fabric_template.network_interface_types[0]
        use_static_mac = true
        mac_address  = format("02:fa:b0:0%s:%02s:00", var.pod, each.value["index"])
    }

    # Add pod user account to the VM
    provisioner "remote-exec" {

        inline = [
        "#!/bin/bash",
        "echo 'Adminsisko$' | sudo -S useradd -m pod${var.pod} -s /bin/bash -p `openssl passwd -1 -stdin <<< 'Admin${var.pod}sisko$'`"
        ]

        connection {
        type     = "ssh"
        user     = "pod"
        password = "Adminsisko$"
        host     = self.clone.0.customize.0.network_interface.0.ipv4_address
        }
    }

}
