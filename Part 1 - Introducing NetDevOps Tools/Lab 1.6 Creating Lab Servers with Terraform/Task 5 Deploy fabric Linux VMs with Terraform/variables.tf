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

variable "server_data" {
    type = map(object({
    name = string
    index = number
    ens224 = string
    }))
}

variable "portgroup_data" {
  type = map(string)
}

variable "server_fabric_data" {
    type = map(object({
    name = string
    index = number
    ens224 = string
    }))
}

