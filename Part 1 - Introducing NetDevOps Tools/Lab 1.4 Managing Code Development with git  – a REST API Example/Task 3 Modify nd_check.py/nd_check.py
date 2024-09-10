#!/usr/bin/python

import sys

import requests
from requests.auth import HTTPBasicAuth
import json

import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

headers = {
            'content-type': "application/json",
            'Cookie': ""
}

def nd_login(host, username, password):
    url = "https://{}/login".format(host)
    response = requests.request("POST", 
                                url, 
                                data=json.dumps({"domain": "DefaultAuth", "userName": username, "userPasswd": password}),
                                headers=headers, 
                                verify=False)
    return response.json()["token"]

if __name__ == "__main__":

    if len(sys.argv) != 4:
        print ("""Usage:
        nd_check.py <pod_number> <user> <password>
    
        where <pod_number> is in 1...5""")
        exit(1)

pod = sys.argv[1]
username = sys.argv[2]
password = sys.argv[3]

# print (f'Arguments: pod {pod}, user {username}, pass {password}')

host = "pod{}-ndfc.sdn.lab".format(pod)
token = nd_login(host, username, password)
print (token)

