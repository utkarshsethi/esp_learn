-- file: setup.lua
local module = {}

local function wifi_wait_ip()
  if wifi.sta.getip()== nil then
    print("IP unavailable, Waiting...")
  else
    tmr.stop(1)
    print("\n====================================")
    print("ESP8266 mode is: " .. wifi.getmode())
    print("MAC address is: " .. wifi.ap.getmac())
    print("IP is "..wifi.sta.getip())
    print("====================================")
    mqtt_start()
  end
end

local function wifi_start(list_aps)
    if list_aps then
        for key,value in pairs(list_aps) do
            if module.SSID and module.SSID[key] then
                wifi.setmode(wifi.STATION);
                wifi.sta.config(key,module.SSID[key])
                wifi.sta.connect()
                print("Connecting to " .. key .. " ...")
                --module.SSID = nil  -- can save memory
                tmr.alarm(1, 2500, 1, wifi_wait_ip)
            end
        end
    else
        print("Error getting AP list")
    end
end

function module.start()

  print("Configuring Wifi ...")
  wifi.setmode(wifi.STATION);
  wifi.sta.getap(wifi_start)

  print("Configuring GPIOs ...")
  for k,v in pairs(module.GPIO) do
      nr = tonumber(k)
      if (v == "INPUT") then
          gpio.mode(nr, gpio.INT, gpio.PULLUP)
      elseif (v == "OUTPUT") then
          gpio.mode(nr, gpio.OUTPUT)
          gpio.write(nr, gpio.LOW)
      end
  end

-- GPIO4 is used as MQTT connection indicator (onboard LED)
  gpio.mode(4, gpio.OUTPUT)
  gpio.write(4, gpio.HIGH)

  mqtt_start()

end

return module
