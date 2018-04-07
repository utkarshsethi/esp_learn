local module = {}

module.SSID = {}
module.SSID["myWifi"] = "12345679ABCDEF"

module.HOST = "m13.cloudmqtt.com"
module.PORT = 16476
module.ID = node.chipid()
module.USER = "node"
module.PASS = "node"

module.ENDPOINT = "nodemcu/"
return module