#!/usr/bin/python

import sys

import requests
from requests.auth import HTTPBasicAuth
import json

from prettytable import PrettyTable

import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

headers = {
            'content-type': "application/json",
            'Cookie': ""
}

def nd_login(host, username, password):
    url = "https://{}/login".format(host)
    try:
        response = requests.request("POST", 
                                    url, 
                                    data=json.dumps({"domain": "DefaultAuth", "userName": username, "userPasswd": password}),
                                    headers=headers, 
                                    verify=False)
        response.raise_for_status()  # Raise an HTTPError for bad responses (4xx and 5xx)
    except requests.exceptions.HTTPError:
        print (f"There was a problem connecting to Cisco ND (status code {response.status_code})\n")
        exit (1)  
        
    return response.json()["token"]

def nd_get_nodes (host):
    url = f"https://{host}/nexus/infra/api/platform/v1/nodes"
    response = requests.request("GET", url, headers=headers, verify=False)
    return (response)

if __name__ == "__main__":

    if len(sys.argv) != 4:
        print ("""Usage:
        nd_check.py <pod_number> <user> <password>
    
        where <pod_number> is in 1...5""")
        exit(1)

pod = sys.argv[1]
username = sys.argv[2]
password = sys.argv[3]

host = "pod{}-ndfc.sdn.lab".format(pod)
token = nd_login(host, username, password)
headers["Cookie"] = f"AuthCookie={token}"
nd_node_data = nd_get_nodes(host)
nd_table = PrettyTable(["Node Name", "Serial Number", "Role", "INB Subnet", "OOB Subnet"])
for item in nd_node_data.json()["items"]:
    nd_table.add_row([item["spec"]["name"], item["spec"]["serialNumber"], 
                    item["spec"]["role"], item["spec"]["inbNetwork"]["subnet"], item["spec"]["oobNetwork"]["subnet"]])
print (nd_table)




