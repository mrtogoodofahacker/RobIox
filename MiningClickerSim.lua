local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Mining Clicker Sim | By Zeta", HidePremium = false, SaveConfig = false, ConfigFolder = "OrionTest"})
repeat task.wait() until game:IsLoaded()
local sfm = require(game.ReplicatedStorage.Modules:WaitForChild("SuffixModule"))
local pm = require(game:GetService("ReplicatedStorage").Modules.pickaxesModule)
local stats = require(game:GetService("ReplicatedStorage").Modules.statModule)
local zstats = require(game:GetService("ReplicatedStorage").Modules.ZoneStats)
local temp = {}
local eggnames = {}
local eggs = {}
local zones = {}
local twcodes = {"UPDATE6","UPDATE5","UPDATE4","Spyder", "10KLikes", "1KLIKES", "RELEASE", "20KLIKES", "UPDATE3"}
local worlds = { ["World 1"] = "Hell Dungeon", ["World 2"] = "Jurassic",["World 3"] = "Dragon City"}
local titles = {"World 1","World 2","World 3"}
local eggblacklist = {"Exclusive Egg 1","1M Visits Egg","10M Visits Egg"}
local selectedegg = "Starter Egg"
local amount = 1
local lp = game.Players.LocalPlayer
local total
local autorebirth = false
local autopick = false
local autoclick = false
local teleports = {}
local abuy = false

local function ClearTbl(tbl)
    for key in pairs(tbl) do
        tbl[key] = nil
    end
end

for i,v in pairs(stats.eggCosts) do
    if not table.find(eggblacklist, i) then 
        table.insert(temp, {tostring(i),v})
    end
end

for i,v in pairs(zstats.zoneNames) do
	local str = string.gsub(v," Zone","")
	if str == "Grass" then
		str = "Spawn"
	end
    table.insert(zones, str)
end

table.sort(temp, function(a,b)
    return a[2] < b[2]
end)

for c,d in pairs(temp) do
    eggs[d[1]] = d[2]
    table.insert(eggnames, d[1])
end

for i,v in pairs(game:GetService("ReplicatedStorage").TeleportPositions:GetChildren()) do
   table.insert(teleports, v.Name) 
end
local Tab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local auto = Tab:AddSection({
	Name = "Automatic Stuff"
})
auto:AddToggle({
	Name = "Auto Rebirth",
	Default = false,
	Callback = function(Value)
		autorebirth = Value
	end    
})
auto:AddToggle({
    Name = "AutoBuy Picks",
    Default = false,
    Callback = function(Value)
        autopick = Value
    end
})
auto:AddToggle({
	Name = "AutoClick",
	Default = false,
	Callback = function(Value)
		autoclick = Value
	end    
})

local pet = Tab:AddSection({
    Name = "hatching"
})

local eg = pet:AddDropdown({
	Name = "Egg Selection",
	Default = "Starter Egg",
	Options = {"Starter Egg"},
	Callback = function(Value)
		selectedegg = Value
	end    
})
eg:Refresh(eggnames, true)

pet:AddSlider({
	Name = "Amount",
	Min = 1,
	Max = 2,
	Default = 1,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Eggs",
	Callback = function(Value)
		amount = Value
	end    
})

local cost = pet:AddLabel("Cost: ".."0")

pet:AddButton({
	Name = "Buy",
	Callback = function()
        game:GetService("ReplicatedStorage").Remotes.buyEgg:InvokeServer(selectedegg, amount)
        OrionLib:MakeNotification({
            Name = "Purchased "..amount.." "..selectedegg.."s",
            Content = "Pet has been Purchased",
            Image = "rbxassetid://4483345998",
            Time = 1.5
        })
  	end    
})

pet:AddToggle({
    Name = "Auto Buy",
    Default = false,
    Callback = function(Value)
        abuy = Value
    end
})

local tele = Window:MakeTab({
    Name = "Teleports",
    Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local t = tele:AddDropdown({
    Name = "Teleports",
    Default = "Spawn",
    Options = {"Spawn"},
    Callback = function(Value)
        game:GetService("ReplicatedStorage").Remotes.TeleportToPlace:InvokeServer(Value)
    end
})
t:Refresh(zones,true)

local wt = tele:AddDropdown({
    Name = "Worlds",
    Default = "World 1",
    Options = {"World 1"},
    Callback = function(Value)
        game:GetService("ReplicatedStorage").Remotes.TeleportToPlace:InvokeServer(worlds[Value])
    end
})

wt:Refresh(titles,true)

tele:AddButton({
    Name = "Tp to Trade World",
    Callback = function()
        if syn then
            syn.queue_on_teleport("loadstring(game:HttpGet(('https://raw.githubusercontent.com/Zet-a/RobIox/main/MiningClickerSim.lua')))()")
        else
            queue_on_teleport("loadstring(game:HttpGet(('https://raw.githubusercontent.com/Zet-a/RobIox/main/MiningClickerSim.lua')))()")
        end
        game:GetService("TeleportService"):Teleport(10148920696, game:GetService("Players").LocalPlayer)
    end
})
if game.PlaceId == 10148920696 then
    tele:AddButton({
        Name = "Back to main game",
        Callback = function()
            if syn then
                syn.queue_on_teleport("loadstring(game:HttpGet(('https://raw.githubusercontent.com/Zet-a/RobIox/main/MiningClickerSim.lua')))()")
            else
                queue_on_teleport("loadstring(game:HttpGet(('https://raw.githubusercontent.com/Zet-a/RobIox/main/MiningClickerSim.lua')))()")
            end
            game:GetService("TeleportService"):Teleport(8884334497, game:GetService("Players").LocalPlayer)
        end
    })
end
tele:AddButton({
    Name = "Rejoin",
    Callback = function()
        if syn then
            syn.queue_on_teleport("loadstring(game:HttpGet(('https://raw.githubusercontent.com/Zet-a/RobIox/main/MiningClickerSim.lua')))()")
        else
            queue_on_teleport("loadstring(game:HttpGet(('https://raw.githubusercontent.com/Zet-a/RobIox/main/MiningClickerSim.lua')))()")
        end
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
    end
})

local pets = Window:MakeTab({
    Name = "Pets",
    Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

pets:AddButton({
    Name = "Upgrade Pets",
    Callback = function()
        for i,v in pairs(game:GetService("HttpService"):JSONDecode(game.Players.LocalPlayer:GetAttribute("inventory"))) do
            for a,b in pairs(v) do
                    game:GetService("ReplicatedStorage").Remotes.CraftToGold:FireServer(b)
                    game:GetService("ReplicatedStorage").Remotes.CraftToGold:FireServer(b,"Golden")
                    game:GetService("ReplicatedStorage").Remotes.CraftToGold:FireServer(b,"Diamond")
                    game:GetService("ReplicatedStorage").Remotes.CraftToGold:FireServer(b,"Emerald")
                    game:GetService("ReplicatedStorage").Remotes.CraftToGold:FireServer(b,"Darkmatter") -- don't make this button into a toggle (destroys your ping)
            end
        end
    end
})
local misc = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

misc:AddButton({
    Name = "Try All Twitter Codes",
    Callback = function()
        for i,v in pairs(twcodes) do
            game:GetService("ReplicatedStorage").Remotes.RedeemCode:InvokeServer(v)
        end
    end
})

game:GetService("RunService").RenderStepped:Connect(function()
    local rebirths = lp:GetAttribute("Rebirths")
    local currentpick = lp:GetAttribute('equippedPick')
    if autorebirth == true then
        if lp:GetAttribute("Coins") >= (5000 + math.floor((rebirths + 1) ^ 4.29205 * 5000)) then
            game:GetService("ReplicatedStorage").Remotes.Rebirth:FireServer()
        end
    end
    if autopick == true then
        for i,v in pairs(pm.picks) do
            if v.Index == pm.picks[currentpick].Index + 1 and v.Cost <= lp:GetAttribute("Coins") then
                game:GetService("ReplicatedStorage").Remotes.BuyPickaxe:InvokeServer(i)
            end
        end
    end
    if autoclick == true then
        game:GetService("ReplicatedStorage").Remotes.Click:InvokeServer()
        game:GetService("ReplicatedStorage").Remotes.swingPick:Fire()
    end
    if abuy == true then
        game:GetService("ReplicatedStorage").Remotes.buyEgg:InvokeServer(selectedegg, amount)
    end
    total = sfm.Suffix(eggs[selectedegg] * amount)
    cost:Set("Cost: "..total)
end)


OrionLib:Init()
