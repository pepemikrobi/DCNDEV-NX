import logging
from pyats import aetest
from genie.conf import Genie

log = logging.getLogger(__name__)

class CommonSetup(aetest.CommonSetup):
    @aetest.subsection
    def establish_connections(self, testbed):
        genie_testbed = Genie.init(testbed)
        self.parent.parameters['testbed'] = genie_testbed
        device_list = []
        for device in genie_testbed.devices.values():
            log.info(f"Connect to device {device.name}")
            try:
                device.connect()
            except Exception:
                self.failed("Failed to establish connection to '{}'".format(
                    device.name))

            device_list.append(device)
        self.parent.parameters.update(dev=device_list)
        self.parent.parameters.update(desire_vni=[
            50000,50001,30011,30012])

class VniTest(aetest.Testcase):
    @aetest.test
    def get_vni(self):
        self.all_vni_status = {}
        for device in self.parent.parameters["dev"]:
            if 'switch' not in device.type.lower():
                continue
            vni = device.parse("show nve vni")
            self.all_vni_status[device.name] = vni["nve1"]["vni"]

    @aetest.test
    def check_vni_status(self):
        result = []
        for device in self.parent.parameters["dev"]:
            if 'switch' not in device.type.lower():
                continue
            log.info(f"Check if all VNI are UP for device {device.name}")
            for key, vni in self.all_vni_status[device.name].items():
                if vni["vni_state"] != "up":
                    result.append({
                        "vni": vni["vni"],
                        "status": vni["vni_state"]
                    })
        if result:
            log.error(result)
            self.failed()

    @aetest.test()
    def desired_vni(self):
        result = []
        for device in self.parent.parameters["dev"]:
            if 'switch' not in device.type.lower():
                continue            
            log.info(f"Check if all desired VNI are deployed on device {device.name}")
            for vni in self.parent.parameters["desire_vni"]:
                if vni not in self.all_vni_status[device.name].keys():
                    result.append(vni)
        if result:
            log.error(result)
            self.failed("not all VNI are deployed")

class ServerPingTest(aetest.Testcase):
    @aetest.test
    def ping_test(self):
        result = []
        for device in self.parent.parameters["dev"]:
            if 'switch' in device.type.lower():
                continue
            log.info(f"Server ping test from {device.name}")
            for remote_device in self.parent.parameters["dev"]:
                if device.name == remote_device.name:
                    log.info(f"Skip ping test to self {device.name}")
                    continue
                if 'switch' in device.type.lower():
                    log.info(f"Skip ping test from switch {device.name}")
                    continue    
                if 'switch' in remote_device.type.lower():
                    log.info(f"Skip ping test to switch {remote_device.name}")
                    continue
                log.info(f"Ping {remote_device.name} ({remote_device.custom.fabric_ip}) from {device.name}") 
                return_code = device.execute(f'ping -c 5 {remote_device.custom.fabric_ip}', code=True)
                if return_code != 0:
                    result.append(f"Failed to ping {remote_device.name} ({remote_device.custom.fabric_ip}) from {device.name}")
        if result:
            log.error(result)
            self.failed("Some ping tests failed")

class CommonCleanup(aetest.CommonCleanup):
    @aetest.subsection
    def clean_everything(self):
        """ Common Cleanup Subsection """
        log.info("Aetest Common Cleanup ")

if __name__ == "__main__":
    aetest.main()
