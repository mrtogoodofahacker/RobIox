repeat task.wait() until game:IsLoaded()

--[------------------------------[ Libraries ]---------------------------------]--
local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'
local lib = loadstring(game:HttpGet(repo .. 'Library.lua'))() --local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local zlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zet-a/RobIox/main/LibrarySnippetRework.lua"))()

--[------------------------------[ Variables ]---------------------------------]--
local vu = game:GetService("VirtualUser")
local plrs = game:GetService("Players")
local lp = plrs.LocalPlayer
local chr = lp.Character
local chests = workspace.Chests
local goldchests = workspace.GoldChests
local ores = workspace.Ores
local oreslidervalue = 500
local selectedore = "Copper"
local autofish = false
local farmchest = false
local farmores = false
local npcs = workspace.NPCs
--local gversion = 21344
local originalpos
-- rbxassetid://7042732937 is the hooked effect texture
--[-------------------------------[ tables ]-----------------------------------]--

--[------------------------------[ Functions ]---------------------------------]--
local function updatelist(list)
	list:SetValues()
	list:Display()
end

local function addore(ore)
    if ore:IsA("Part") and ore.Name == "Part" then
        for i,v in pairs(ore:GetChildren()) do
            zlib:CTT(v.Name)
            zlib:text(v,-2,0,v.Name,{
                Text = v.Name,
                Visible = false,
                Outline = true,
                OutlineColor = Color3.fromRGB(0, 0, 0),
                Color = v.Color,
                Center = true,
                Font = 2,
            })
        end
    end
end
------------------------------------Calls-----------------------------------------
zlib:CTT("Chest",{
    HaveSlider = true,
}) -- CTT = CreateToggleTable
zlib:CTT("Mela",{
    HaveSlider = false
})
-------------------------------------Code-----------------------------------------
--[[
if game.PlaceVersion >= gversion then
    if game.PlaceVersion == gversion then
        
    else
        lib:Notify("Warning! Exploit not updated to latest game version.")
        lib:Notify("Use unsafe menu features with caution.")
    end
end
]]--

local window = lib:CreateWindow({
	Title = "Obsidian (Pilgrammed)",
	Center = true,
	AutoShow = true,
})

local Tabs = {
    esptab = window:AddTab("Esp"),
    autotab = window:AddTab("Autofarms"),
    --unsafetab = window:AddTab("Unsafe"),
    settingtab = window:AddTab("Settings"),
}

local chestgroup = Tabs.esptab:AddLeftGroupbox("Chest")
chestgroup:AddToggle("ShowChests",{
    Text = "Show Chests",
    Default = false,
    Tooltip = "Shows regular chests",
})

chestgroup:AddToggle("ShowChestBox",{
    Text = "Box",
    Default = false,
    Tooltip = "Shows chests' box"
})

chestgroup:AddToggle("ShowChestTitle",{
    Text = "Title",
    Default = false,
    Tooltip = "Shows chests' title"
})

chestgroup:AddSlider("ChestSlider",{
    Text = "Distance",
    Default = 500,
    Min = 500,
    Max = 7000,
    Rounding = 1,
    Compact = false,
})

local oregroup = Tabs.esptab:AddRightGroupbox("Ores")

oregroup:AddDropdown("SelectOre",{
    Values = {"Copper","Tin","Zinc","Iron","Sulfur","Emerald","Ruby","Sapphire","Mithril","Demetal","Diamond","Darksteel"},
    Default = 1,
	Multi = false,
	Text = "Ores",
	Tooltip = "Click ore to show & edit its title visibility.",
})

oregroup:AddToggle("ShowOreTitle",{
    Text = "Show Title",
    Default = false,
    Tooltip = "Shows selected ore title",
})

local miscespgroup = Tabs.esptab:AddRightGroupbox("Misc")

miscespgroup:AddToggle("ShowGemShop",{
    Text = "Show Traveling Shop",
    Default = false,
    Tooltip = "Shows gem shop",
})

local fishgroup = Tabs.autotab:AddLeftGroupbox("AutoFish (Beta)")

fishgroup:AddToggle("AutoFish",{
    Text = "Toggle",
    Default = false,
    Tooltip = "Toggles autofish"
}):AddKeyPicker("AutoFishKeybind",{
    Default = 'H',
    SyncToggleState = true, 
    Mode = 'Toggle',
    Text = 'Auto Fish',
    NoUI = false,
})

fishgroup:AddLabel("Point mouse at close waters (30stds)")
fishgroup:AddLabel("This obviously requires a fishing rod")

--local unsafeleftgroup = Tabs.unsafetab:AddLeftGroupbox("Auto")
--unsafeleftgroup:AddLabel("Use this stuff at your own risk!")

for i,v in pairs(chests:GetChildren()) do
    if v:FindFirstChild("Root") then
        local root = v.Root
        zlib:box(root,"Chest",{
            Color = Color3.fromRGB(126, 91, 52),
        })
        zlib:text(root,-2, 0,"Chest",{
            Text = "Chest",
            Color = Color3.fromRGB(126, 91, 52),
            Visible = false,
            Outline = true,
            OutlineColor = Color3.fromRGB(0, 0, 0),
            Center = true,
            Font = 2,
        })
    end
end

for i,v in pairs(goldchests:GetChildren()) do
    if v:FindFirstChild("Root",true) then
        local root = v.Root
        zlib:box(root,"Chest",{
            Color = Color3.fromRGB(233, 218, 12),
        })
        zlib:text(root,-2, 0,"Chest",{
            Text = "Gold Chest",
            Color = Color3.fromRGB(233, 218, 12),
            Visible = false,
            Outline = true,
            OutlineColor = Color3.fromRGB(0, 0, 0),
            Center = true,
            Font = 2,
        })
    end
end

if npcs:FindFirstChild("Mela") then
    zlib:text(npcs.Mela.HumanoidRootPart,-2,0,"Mela",{
        Text = "Traveling Shop",
        Color = npcs.Mela.Head.Color,
        Visible = false,
        Outline = true,
        OutlineColor = Color3.fromRGB(0, 0, 0),
        Center = true,
        Font = 2,
    })
end

for i,v in pairs(ores:GetChildren()) do
    for a,b in pairs(v:GetChildren()) do
        if b:FindFirstChild("Part") then
            addore(b.Part)
        end
    end
end

Toggles.ShowChests:OnChanged(function()
    __Variables["Chest"].Toggle = Toggles.ShowChests.Value
end)

Toggles.ShowChestBox:OnChanged(function()
    __Variables["Chest"].Box = Toggles.ShowChestBox.Value
end)

Toggles.ShowChestTitle:OnChanged(function()
    __Variables["Chest"].Title = Toggles.ShowChestTitle.Value
end)

Options.ChestSlider:OnChanged(function()
    __Variables["Chest"].Slider = Options.ChestSlider.Value
end)

Options.SelectOre:OnChanged(function()
    selectedore = Options.SelectOre.Value
    local title = __Variables[selectedore].Title
    Toggles.ShowOreTitle:SetValue(title)
end)

Toggles.ShowOreTitle:OnChanged(function()
    __Variables[selectedore].Toggle = Toggles.ShowOreTitle.Value -- would do box esp as well but its too laggy
    __Variables[selectedore].Title = Toggles.ShowOreTitle.Value
end)

Toggles.AutoFish:OnChanged(function()
    autofish = Toggles.AutoFish.Value
end)

Toggles.ShowGemShop:OnChanged(function()
    __Variables["Mela"].Toggle = Toggles.ShowGemShop.Value
    __Variables["Mela"].Title = Toggles.ShowGemShop.Value
end)

ores.DescendantAdded:Connect(function(v)
    addore(v)
end)

chests.ChildAdded:Connect(function(v)
    if v:WaitForChild("Root",5) then
        local root = v.Root
        zlib:box(root,"Chest",{
            Color = Color3.fromRGB(126, 91, 52),
        })
        zlib:text(root,-2, 0,"Chest",{
            Text = "Chest",
            Color = Color3.fromRGB(126, 91, 52),
            Visible = false,
            Outline = true,
            OutlineColor = Color3.fromRGB(0, 0, 0),
            Center = true,
            Font = 2,
        })
    end
end)

local clickdb = false
local initiateautofish = false
local ancestrydb = false -- fix attempt
task.spawn(function()
    while task.wait() do
        if autofish == true then

            if initiateautofish == true then
                vu:Button1Down(Vector2.new(0,0),zlib.__Tools.camera.CFrame)
                vu:Button1Up(Vector2.new(0,0),zlib.__Tools.camera.CFrame)
            end
            initiateautofish = false
            for i,v in pairs(chests:GetChildren()) do
                if v.Name == "Fishing" and v:FindFirstChildWhichIsA("ProximityPrompt") and v:FindFirstChild("Root") then
                    local mag = (v.Root.Position - lp.Character.HumanoidRootPart.Position).magnitude
                    if mag <= 20 then
                        fireproximityprompt(v.ProximityPrompt,2)
                    end
                end
            end
            for i,v in pairs(workspace:GetChildren()) do
                if v.Name == "Bobber" then
                    local bob = v
                    local mag = (bob.Position - lp.Character.HumanoidRootPart.Position).magnitude
                    if mag <= 30 then
                        if bob:WaitForChild("Attachment",5) and bob.Attachment:WaitForChild("Hooked") then
                            if bob.Attachment.Hooked.Enabled == true then
                                if clickdb == false then
                                    clickdb = true
                                    vu:Button1Down(Vector2.new(0,0),zlib.__Tools.camera.CFrame)
                                    vu:Button1Up(Vector2.new(0,0),zlib.__Tools.camera.CFrame)
                                    task.wait(0.1)
                                clickdb = false
                                end
                            end
                        end
                    end
                    bob.AncestryChanged:Connect(function()
                        if not bob:IsDescendantOf(game) then
                            if ancestrydb == false then
                                ancestrydb = true
                                vu:Button1Down(Vector2.new(0,0),zlib.__Tools.camera.CFrame)
                                vu:Button1Up(Vector2.new(0,0),zlib.__Tools.camera.CFrame)
                                task.wait(1)
                                ancestrydb = false
                            end
                        end
                    end)
                end
            end
        else
            initiateautofish = true
        end
    end
end)
----------------------------------------------------------------------------------
local settingsgroup = Tabs.settingtab:AddLeftGroupbox("Menu")
settingsgroup:AddButton('Unload', function() lib:Unload() end)
settingsgroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'RightShift', NoUI = true, Text = 'Menu keybind' })
lib.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(lib)
SaveManager:SetLibrary(lib)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('Obsidian')
SaveManager:SetFolder('Obsidian/'..tostring(game.PlaceId))
SaveManager:BuildConfigSection(Tabs.settingtab)
ThemeManager:ApplyToTab(Tabs.settingtab)
lib:Notify("Made by Zeta") -- For Credits (Don't remove)
