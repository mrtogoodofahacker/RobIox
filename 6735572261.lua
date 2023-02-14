repeat task.wait() until game:IsLoaded()

--[------------------------------[ Libraries ]---------------------------------]--
local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'
local lib = loadstring(game:HttpGet(repo .. 'Library.lua'))() --local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local zlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zet-a/RobIox/main/LibrarySnippetRework.lua"))()

--[------------------------------[ Variables ]---------------------------------]--
local plrs = game:GetService("Players")
local lp = plrs.LocalPlayer
local chests = workspace.Chests
local goldchests = workspace.GoldChests
local ores = workspace.Ores
local oreslidervalue = 500
local selectedore = "Copper"
--[-------------------------------[ Tables ]-----------------------------------]--

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

-------------------------------------Code-----------------------------------------

local window = lib:CreateWindow({
	Title = "Obsidian (Pilgrammed)",
	Center = true,
	AutoShow = true,
})

local Tabs = {
    esptab = window:AddTab("Esp"),
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
