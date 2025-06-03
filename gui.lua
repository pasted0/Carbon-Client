
shared.VapeIndependent = true
local vape = loadstring(game:HttpGet('https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua', true))()

local foundplace = nil
for _,filename in next, listfiles("CarbonClient/Games") do
  if filename:find(tostring(game.PlaceId)) then 
    foundplace = "CarbonClient/Games/"..tostring(game.PlaceId)
    break
  end
end

if foundplace then
  loadstring(readfile(foundplace))()
  else
    loadstring(readfile("CarbonClient/Games/Universal.lua"))()
end

