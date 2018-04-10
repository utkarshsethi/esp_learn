local module = {}

--wifi
module.SSID = {}
module.SSID["myWifi"] = "12345679ABCDEF"

--mqtt server
module.HOST = "m13.cloudmqtt.com"
module.PORT = 16476
module.ID = node.chipid()
module.USER = "node"
module.PASS = "node"
module.ENDPOINT = "nodemcu/"

-- Relays
module.GPIO[0] = "OUTPUT"
module.GPIO[1] = "OUTPUT"
module.GPIO[2] = "OUTPUT"
module.GPIO[3] = "OUTPUT"

-- GPIO4 is used as MQTT connection indicator (onboard LED)

-- Buttons
module.GPIO[5] = "INPUT"
module.GPIO[6] = "INPUT"
module.GPIO[7] = "INPUT"





return module
