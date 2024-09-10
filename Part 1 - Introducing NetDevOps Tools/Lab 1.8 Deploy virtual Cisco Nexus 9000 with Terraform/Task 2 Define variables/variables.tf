variable "vcsa_hostname" {
}

variable "esxi_hostname" {
}

variable "esxi_datastore" {
}

variable "vcsa_username" {
}

variable "vcsa_password" {
}

variable "pod" {
}

variable "dc1_switch_data" {
  type = map(object({
    name = string
    index = number
    serial_port = string
    eth1 = string
    eth2 = string
    eth3 = string
    eth4 = string
  }))
}

variable "dc2_switch_data" {
  type = map(object({
    name = string
    index = number
    serial_port = string
    eth1 = string
    eth2 = string
    eth3 = string
    eth4 = string
  }))
}

variable "portgroup_data" {
  type = map(string)
}