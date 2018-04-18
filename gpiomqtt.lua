local module = {}
m = nil

function str_split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {} ; i = 1
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end


local function mqtt_start()
    m = mqtt.Client(config.ID, 120, config.USER, config.PASS)
    m:lwt("/gpio", "OFFLINE VIA LWT", 0, 0)

    -- register message callback beforehand
    m:on("message", function(conn, topic, data)
        print("MQTT < " .. topic .. " " .. data)

        numGpio = 4
        timeout = nil

        value = data
        if (value == true or value == 1 or value == "1" or value == "true") then
            gpio.write(numGpio, gpio.HIGH)
            print("MQTT > " .. config.ENDPOINT .. numGpio .. " 1")
            m:publish(config.ENDPOINT .. numGpio, 1, 0, 1)
            n = gpio.LOW

        elseif (value ~= nil) then
            gpio.write(numGpio, gpio.LOW)
            print("MQTT > " .. config.ENDPOINT .. numGpio .. " 0")
            m:publish(config.ENDPOINT .. numGpio, 0, 0, 1)
            n = gpio.HIGH
        else
            n = nil
        end

        if (timeout ~= nil and n ~= nil) then
            tmr.alarm(numGpio, timeout, tmr.ALARM_SINGLE, function ()
                gpio.write(numGpio, n)
                print("MQTT > " .. config.ENDPOINT .. numGpio .. " " .. n)
                m:publish(config.ENDPOINT .. numGpio, n, 0, 1)
            end)
        end
    end)

    m:on("offline", function()
        print("MQTT offline")
        gpio.write(4, gpio.LOW)
    end)

    -- Connect to broker
    m:on("connect", function()
            print("MQTT connected")
            gpio.write(4, gpio.LOW)
            m:subscribe(config.ENDPOINT, 0, function(conn)
                print("MQTT subscribed " .. config.ID .. " to " .. config.ENDPOINT)
            end)
            m:publish(config.ENDPOINT, "HELLO(node)", 0, 1)
              print("MQTT > " .. config.ENDPOINT .. " HELLO(node)")
        end)

    m:connect(config.HOST, config.PORT,0,0)


end


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
            if config.SSID and config.SSID[key] then
                wifi.setmode(wifi.STATION);
                wifi.sta.config{ssid=key,pwd=config.SSID[key]}
                wifi.sta.connect()
                print("Connecting to SSID: " .. key .. " ...")
                --config.SSID = nil  -- can save memory
                tmr.alarm(1, 2500, 1, wifi_wait_ip)
            end
        end
    else
        print("Error getting AP list")
    end
end

print("Configuring GPIOs ...")
for k = 0,3,1 do
  print(k," ")
        gpio.mode(k, gpio.OUTPUT)
        gpio.write(k, gpio.LOW)
end
gpio.mode(4, gpio.OUTPUT)
gpio.write(4, gpio.HIGH)
print("... DONE")

print("Configuring Wifi ...")
wifi.setmode(wifi.STATION);
wifi.sta.getap(wifi_start)

return module
