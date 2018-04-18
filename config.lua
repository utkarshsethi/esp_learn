config = {}

-- WIFI
config.SSID = {}
config.SSID["prasad"] = "AkasHPrasaD3#"
config.SSID["wifi"] = "hihihi123"


-- MQTT
config.HOST = "m13.cloudmqtt.com"
config.PORT = 16476
config.ID = "esp1"
config.ENDPOINT = "/gpio"
config.USER = "test"
config.PASS = "test"
config.MQTLS = 0 -- 0 = unsecured, 1 = TLS/SSL

config.GPIO = {}
-- LEDs
config.GPIO[0] = "OUTPUT"
config.GPIO[1] = "OUTPUT"
config.GPIO[2] = "OUTPUT"
config.GPIO[3] = "OUTPUT"
-- GPIO4 is used as MQTT connection indicator (onboard LED)
config.GPIO[4] = "OUTPUT"
