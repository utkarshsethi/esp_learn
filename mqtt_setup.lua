-- file : application.lua
local module = {}
m = nil

-- Sends a simple ping to the broker
local function send_ping()
    m:publish(module.ENDPOINT .. "ping","id=" .. module.ID,0,0)
end

-- Sends my id to the broker for registration
local function register_myself()
    m:subscribe(module.ENDPOINT .. module.ID,0,function(conn)
        print("Successfully subscribed to data endpoint")
    end)
end

local function mqtt_start()
    m = mqtt.Client(module.ID, 120, module.USER)
    -- register message callback beforehand
    m:on("message", function(conn, topic, data)
      if data ~= nil then
        print(topic .. ": " .. data)
        -- do something, we have received a message
      end
    end)
    -- Connect to broker
    m:connect(module.HOST, module.PORT, 0, 1, function(con)
        register_myself()
        -- And then pings each 1000 milliseconds
        tmr.stop(6)
        tmr.alarm(6, 1000, 1, send_ping)
    end)

end

return module
