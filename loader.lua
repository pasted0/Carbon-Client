local request = http.request or http_request or httprequest

local function getFile(FileName)
    local options = {
        Method = 'GET',
        Url = "https://api.github.com/repos/pasted0/Carbon-Client/contents/"..FileName,
        Headers = {
            ["Accept"] = "application/vnd.github.v3.raw"
        }
    }
    return request(options).Body
end


local function isfile(file)
    local suc, res = pcall(function() return readfile(file) end)
    return suc and res ~= nil and res ~= ''
end

local function isfolder(folder)
    local suc, res = pcall(function() return listfiles(folder) end)
    return suc and type(res) == "table" and #res > 0
end

if not isfolder("CarbonClient") then 
    makefolder("CarbonClient")
end

if not isfile("CarbonClient/loader.lua") then
    writefile("CarbonClient/loader.lua", getFile("loader.lua"))
end

if not isfile("CarbonClient/gui.lua") then
    writefile("CarbonClient/gui.lua", getFile("gui.lua"))
end

if not isfolder("CarbonClient/Games") then
    makefolder("CarbonClient/Games")
    local suc, err = pcall(function()
      writefile("CarbonClient/Games/"..game.PlaceId..".lua", getFile("Games/"..game.PlaceId..".lua"))
    end)
end

writefile("CarbonClient/_VERSION", "@CarbonClient 1.0, all rights reserved.")
task.wait(1)
loadstring(readfile("CarbonClient/gui.lua"))()
