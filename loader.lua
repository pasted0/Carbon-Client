local request = http.request or http_request or httprequest

local function getFile(FileName)
    local options = {
        Method = 'GET',
        Url = "https://api.github.com/repos/pasted0/Carbon-Client/contents/"..FileName,
        Headers = {
            ["Accept"] = "application/vnd.github.v3.raw"
        }
    }
    return request(options)
end

local function getFolder(FolderName)
    local options = {
        Method = 'GET',
        Url = "https://api.github.com/repos/pasted0/Carbon-Client/contents/"..FolderName,
        Headers = {
            ["Accept"] = "application/vnd.github.v3+json"
        }
    }
    local res = request(options)
    if res and res.Body then
        local http = cloneref(game:GetService("HttpService"))
        local data = http:JSONDecode(res.Body)
        local contents = {}
        for _, item in next, data do
            contents[#contents + 1] = {
                name = item.name,
                path = item.path,
                type = item.type,
                download_url = item.download_url
            }
        end
        return contents
    end
    return {}
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
    writefile("CarbonClient/loader.lua", getFile("loader.lua").Body)
end

if not isfile("CarbonClient/gui.lua") then
    writefile("CarbonClient/gui.lua", getFile("gui.lua").Body)
end

if not isfolder("CarbonClient/Games") then 
  makefolder("CarbonClient/Games")
  for _, file in next, getFolder("Games") do
    writefile("CarbonClient/Games/"..file.name, getFile(file.path))
  end
end

dofile("CarbonClient/gui.lua")