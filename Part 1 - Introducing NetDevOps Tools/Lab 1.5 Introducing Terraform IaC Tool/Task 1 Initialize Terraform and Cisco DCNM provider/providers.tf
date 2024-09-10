terraform {
    required_providers {
        dcnm = {
            source = "CiscoDevNet/dcnm"
        }
    }
}

provider "dcnm" {
    username = "admin"
    password = "AdmeenXsisko"
    url = "https://podX-ndfc.sdn.lab"
    insecure = "true"
    platform = "nd"
}
