local repo,file="RMuskovets/OCOS","installer/main.lua"
require("component").eeprom.set([[
    local handle, data, chunk = component.proxy(component.list("internet")()).request("https://raw.githubusercontent.com/]]..repo..[[/master/]]..file..[["), ""
   
    while true do
        chunk = handle.read(math.huge)
        if chunk then
            data = data .. chunk
        else
            break
        end
    end
 
    handle.close()
    load(data)()
]])