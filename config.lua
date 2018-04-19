config = {}

-- WIFI
config.SSID = {}
config.SSID["ssid1"] = "pass1"
config.SSID["ssid2"] = "pass2"
config.SSID["ssid3"] = "pass3"
--...
--...

-- MQTT
config.HOST = "host address"
config.PORT = PORT
config.ID = "node name"
config.ENDPOINT = "topic path before your directory"
config.USER = "test"
config.PASS = "test"
config.MQTLS = 0 -- 0 = unsecured, 1 = TLS/SSL; for future expansion

config.GPIO = {}
-- LEDs
config.GPIO[0] = "OUTPUT"
config.GPIO[1] = "OUTPUT"
config.GPIO[2] = "OUTPUT"
config.GPIO[3] = "OUTPUT"
-- GPIO4 is used as MQTT connection indicator (onboard LED)
config.GPIO[4] = "OUTPUT"
