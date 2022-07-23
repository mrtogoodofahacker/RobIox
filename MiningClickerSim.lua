local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Mining Clicker Sim | By Zeta", HidePremium = false, SaveConfig = false, ConfigFolder = "OrionTest"})
local sfm = require(game.ReplicatedStorage.Modules:WaitForChild("SuffixModule"))
local pm = require(game:GetService("ReplicatedStorage").Modules.pickaxesModule)

local twcodes = {"UPDATE4","Spyder", "10KLikes", "1KLIKES", "RELEASE", "20KLIKES", "UPDATE3"}
local selectedegg = "Starter Egg"
local amount = 1
local valnum = 1
local eggvalues = {se = 320, spe = 1200,fe = 10000,de = 100000,sne = 1000000,ce = 7500000,oe = 20000000,je = 120000000,ve = 400000000,spae = 1800000000,ue = 15000000000,he = 150000000000,dve = 500000000000,foe = 100000000000000,te = 500000000000000,me = 15000000000000000}
local lp = game.Players.LocalPlayer
local total
local autorebirth = false
local autopick = false
local autoclick = false
local tnme = "Spawn"
local teleports = {}
local abuy = false

for i,v in pairs(workspace.TeleportBricks:GetChildren()) do
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

pet:AddDropdown({
	Name = "Egg Selection",
	Default = "Starter Egg",
	Options = {"Starter Egg", "Spotted Egg", "Floral Egg", "Desert Egg", "Snow Egg","Cave Egg","Ocean Egg","Volcano Egg","Space Egg","Undead Egg","Heavenly Egg","Devil Egg","Fossil Egg","Tentacle Egg","Mummy Egg"},
	Callback = function(Value)
		selectedegg = Value
        if selectedegg == "Starter Egg" then
            valnum = "se"
        elseif selectedegg == "Spotted Egg" then
            valnum = "spe"
        elseif selectedegg == "Floral Egg" then
            valnum = "fe"
        elseif selectedegg == "Desert Egg" then
            valnum = "de"
        elseif selectedegg == "Snow Egg" then
            valnum = "sne"
        elseif selectedegg == "Cave Egg" then
            valnum = "ce"
        elseif selectedegg == "Ocean Egg" then
            valnum = "oe"
        elseif selectedegg == "Jungle Egg" then
            valnum = "je"
        elseif selectedegg == "Volcano Egg" then
            valnum = "ve"
        elseif selectedegg == "Space Egg" then -- lord...
            valnum = "spae"
        elseif selectedegg == "Undead Egg" then
            valnum = "ue"
        elseif selectedegg == "Heavenly Egg" then
            valnum = "he"
        elseif selectedegg == "Devil Egg" then
            valnum = "dve"
        elseif selectedegg == "Fossil Egg" then
            valnum = "foe"
        elseif selectedegg == "Tentacle Egg" then
            valnum = "te"
        elseif selectedegg == "Mummy Egg" then
            valnum = "me"
        end
	end    
})

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
    Options = {},
    Callback = function(Value)
       tnme = Value
    end
})

t:Refresh(teleports,true)

local tb = tele:AddButton({
    Name = "Teleport",
    Callback = function()
        lp.Character:MoveTo(workspace.TeleportBricks[tnme].Position) 
    end
})

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
    total = sfm.Suffix(eggvalues[valnum] * amount)
    cost:Set("Cost: "..total)
end)



OrionLib:Init()
