local zlib = loadstring(game:HttpGet('https://raw.githubusercontent.com/Zet-a/RobIox/main/LibrarySnippet.lua'))()
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/Library.lua"))()
local rocks = workspace.World.RockRegions.Island
local orewhitelist = {"Gold","Mythril"}
local selected = "Mythril"
local instance = {
    Mythril = {
        color = Color3.fromRGB(90,166,165)
    },
    Gold = {
        color = Color3.fromRGB(221,146,17)
    },
    Iron = {
        color = Color3.fromRGB(111,107,118)
    },
    Pyrite = {
        color = Color3.fromRGB(207,165,15)
    },
    Tin = {
        color = Color3.fromRGB(229,228,223)
    },
    Copper = {
        color = Color3.fromRGB(206,98,35)
    }
}
local currentinstances = {

}

for i,v in pairs(rocks:GetDescendants()) do
    for a,b in pairs(instance) do
        if string.find(v.Name,a) then
            local instance = v.Parent.Parent
            if not table.find(currentinstances,instance) then
                table.insert(currentinstances,instance)
                zlib:box(instance,string.match(v.Name,a),{
                     Color = b.color
                })
                zlib:text(instance,-2,0,string.match(v.Name,a).."title",{
                    Text = string.match(v.Name,a),
                    Visible = false,
                    Outline = true,
                    OutlineColor = Color3.fromRGB(0,0,0),
                    Color = b.color,
                    Center = true,
                    Font = 2
                })
            end
        end
    end
end
rocks.DescendantAdded:Connect(function(v)
    for a,b in pairs(instance) do
        if string.find(v.Name,a) then
            local instance = v.Parent.Parent
            if not table.find(currentinstances,instance) then
                table.insert(currentinstances,instance)
                zlib:box(instance,string.match(v.Name,a),{
                     Color = b.color
                })
                zlib:text(instance,-2,0,string.match(v.Name,a).."title",{
                    Text = string.match(v.Name,a),
                    Visible = false,
                    Outline = true,
                    OutlineColor = Color3.fromRGB(0,0,0),
                    Color = b.color,
                    Center = true,
                    Font = 2
                })
            end
        end
    end
end)

local window = lib:CreateWindow({
    Title = 'Obsidian (Oaklands)',
    Center = true,
    AutoShow = true,
})

local Tabs = {
    Main = window:AddTab('Main')
}

local mainleftgroupbox = Tabs.Main:AddLeftGroupbox('Automatic stuff')
mainleftgroupbox:AddDropdown('SelectOre',{
    Values = {"Mythril","Gold","Iron","Pyrite","Tin","Copper"},
    Default = 1,
    Multi = false,
    Text = "Ores",
    Tooltip = "Click the type of ore to show edit its title or box visibility."
})
mainleftgroupbox:AddToggle('ShowBox',{
    Text = "Show Box",
    Default = false,
    Tooltip = "Shows esp box"
})
mainleftgroupbox:AddToggle('Showtitle',{
    Text = "Show Title",
    Default = false,
    Tooltip = "Shows esp title"
})
Toggles.ShowBox:OnChanged(function()
    __Variables[selected] = Toggles.ShowBox.Value
end)

Toggles.Showtitle:OnChanged(function()
    __Variables[selected.."title"] = Toggles.Showtitle.Value
end)

Options.SelectOre:OnChanged(function()
    selected = Options.SelectOre.Value
    local title = __Variables[selected.."title"] -- quick fix
    local box = __Variables[selected] -- quick fix
    Toggles.Showtitle:SetValue(title)
    Toggles.ShowBox:SetValue(box)
end)
