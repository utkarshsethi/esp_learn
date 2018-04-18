config = {}

-- WIFI
config.SSID = {}
config.SSID["ssid1"] = "pass1"
config.SSID["ssid2"] = "pass2"


-- MQTT
config.HOST = "server address"
config.PORT = 1234
config.ID = "esp1"
config.ENDPOINT = "/tpoic"
config.USER = "test"
config.PASS = "test"
config.MQTLS = 0 -- 0 = unsecured, 1 = TLS/SSL FOR FUTURE EXPANSION

config.GPIO = {}
-- LEDs
config.GPIO[0] = "OUTPUT"
config.GPIO[1] = "OUTPUT"
config.GPIO[2] = "OUTPUT"
config.GPIO[3] = "OUTPUT"
-- GPIO4 is used as MQTT connection indicator (onboard LED)
config.GPIO[4] = "OUTPUT"
