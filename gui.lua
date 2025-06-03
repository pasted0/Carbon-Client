
shared.VapeIndependent = true
local vape = loadstring(game:HttpGet('https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua', true))()

local foundplace = nil
for _,filename in next, listfiles("CarbonClient/Games") do
  if filename:find(tostring(game.PlaceId)) then 
    foundplace = "Games/"..tostring(game.PlaceId)
    return
  end
end

vape.Place = foundplace or "Games/Universal.lua"
vape:Init()
