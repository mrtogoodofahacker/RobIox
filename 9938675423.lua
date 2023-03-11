local zlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zet-a/RobIox/main/LibrarySnippet.lua"))()
local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'
local lib = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local rocks = workspace.World.RockRegions
local trees = workspace.World.TreeRegions
local selected = "Mythril"
local ores = {
    Magnetite = {
        ["rbxassetid://12100885933"] = BrickColor.new("Bright violet")
    },
	Adurite = {
		["rbxassetid://12100886068"] = BrickColor.new("Bright red")
	},
    ["Rosa Quartz"] = {
        ["rbxassetid://12100886051"] = BrickColor.new("Carnation pink")
    },
	Mythril = {
		["rbxassetid://12100886066"] = BrickColor.new("Med. bluish green"),
		["rbxassetid://12100886051"] = BrickColor.new("Med. bluish green"),
		["rbxassetid://12100886068"] = BrickColor.new("Med. bluish green")
	},
	Gold = {
		["rbxassetid://12100885942"] = BrickColor.new("Br. yellowish orange"),
		["rbxassetid://12100885949"] = BrickColor.new("Br. yellowish orange"),
		["rbxassetid://12100885963"] = BrickColor.new("Br. yellowish orange")
	},
	Iron = {
		["rbxassetid://12100886003"] = BrickColor.new("Dark grey"),
		["rbxassetid://12100886012"] = BrickColor.new("Dark grey"),
		["rbxassetid://12100886011"] = BrickColor.new("Dark grey")
	},
	Pyrite = {
		["rbxassetid://12100885937"] = BrickColor.new("Flame yellowish orange"),
		["rbxassetid://12100885933"] = BrickColor.new("Flame yellowish orange"),
		["rbxassetid://12100885936"] = BrickColor.new("Flame yellowish orange")
	},
    Quartz = {
        ["rbxassetid://12100886068"] = BrickColor.new("Institutional white"),
        ["rbxassetid://12100886066"] = BrickColor.new("Institutional white"),
        ["rbxassetid://12100886051"] = BrickColor.new("Institutional white")
    },
	Tin = {
		["rbxassetid://12100886049"] = BrickColor.new("Light stone grey"),
		["rbxassetid://12100886035"] = BrickColor.new("Light stone grey"),
		["rbxassetid://12100886020"] = BrickColor.new("Light stone grey")
	},
	Copper = {
		["rbxassetid://12100885998"] = BrickColor.new("Flame reddish orange"),
		["rbxassetid://12100885960"] = BrickColor.new("Flame reddish orange"),
		["rbxassetid://12100885958"] = BrickColor.new("Flame reddish orange")
	},
	Ink = {
		["rbxassetid://12627880491"] = BrickColor.new("Black metallic"),
	},
	Bluesteel = {
		["rbxassetid://12100885949"] = BrickColor.new("Steel blue"),
		["rbxassetid://12100885963"] = BrickColor.new("Steel blue"),
		["rbxassetid://12100885942"] = BrickColor.new("Steel blue"),
	},
	Lithium = {
		["rbxassetid://12100885936"] = BrickColor.new("Dark grey"),
		["rbxassetid://12100885933"] = BrickColor.new("Dark grey"),
	},
	Cobalt = {
		["rbxassetid://12100885949"] = BrickColor.new("Burlap"),
		["rbxassetid://12100885963"] = BrickColor.new("Burlap"),
	},
	Zinc = {
		["rbxassetid://12100885963"] = BrickColor.new("Light lilac"),
		["rbxassetid://12100885949"] = BrickColor.new("Light lilac"),
	},
	["Rose Gold"] = {
		["rbxassetid://12100885942"] = BrickColor.new("Salmon"),
		["rbxassetid://12100885963"] = BrickColor.new("Salmon"),
	},
	Palladium = {
		["rbxassetid://12100885963"] = BrickColor.new("Light orange brown"),
	},
	Uranium = {
		-- Still gotta find this one
	},
	Sand = {
		["rbxassetid://12100886098"] = BrickColor.new("Buttermilk"),
	}
}

local function hasProperty(object, prop)
    local success = pcall(function()local temp = object[prop]end)
	return success
end

local function addTree(tree)
	if hasProperty(tree, "CanCollide") and tree.CanCollide == true then
		for i, v in pairs(trees) do
			for o, b in pairs(v) do
				if tree.BrickColor == b then
					zlib:text(tree, -2, 0, "Treetitle", {
						Text = i,
						Visible = false,
						Outline = true,
						OutlineColor = Color3.fromRGB(0, 0, 0),
						Color = Color3.fromRGB(230, 157, 21),
						Center = true,
						Font = 2,
					})
				end
			end
		end
	end
end

local function addOre(ore)
	if hasProperty(ore, "CanCollide") and ore.CanCollide == false then
		for i, v in pairs(ores) do
			for o, b in pairs(v) do
				if --[[ tostring(ore.MeshId) == o and ]] ore.BrickColor == b then
					--[[ zlib:box(ore.Parent.Parent, i, {
						Color = b.Color,
					}) ]]
					zlib:text(ore.Parent.Parent, -2, 0, i .. "title", {
						Text = i,
						Visible = false,
						Outline = true,
						OutlineColor = Color3.fromRGB(0, 0, 0),
						Color = b.Color,
						Center = true,
						Font = 2,
					})
				end
			end
		end
	end
end

for _, v in pairs(rocks:GetDescendants()) do
	addOre(v)
end
rocks.DescendantAdded:Connect(function(v)
	addOre(v)
end)

local window = lib:CreateWindow({
	Title = "Obsidian (Oaklands)",
	Center = true,
	AutoShow = true,
})

local Tabs = {
	Main = window:AddTab("Main"),
    settingtab = window:AddTab("Settings"),
}

local mainleftgroupbox = Tabs.Main:AddLeftGroupbox("Automatic stuff")
mainleftgroupbox:AddDropdown("SelectOre", {
	Values = { "Magnetite", "Bluesteel", "Adurite", "Mythril", "Cobalt", "Palladium", "Rosa Quartz", "Rose Gold", "Gold", "Iron", "Zinc", "Lithium", "Ink","Pyrite", "Quartz", "Tin", "Copper" },
	Default = 1,
	Multi = false,
	Text = "Ores",
	Tooltip = "Click the type of ore to show edit its title or box visibility.",
})
--[[ mainleftgroupbox:AddToggle("ShowBox", {
	Text = "Show Box",
	Default = false,
	Tooltip = "Shows esp box",
}) ]]
mainleftgroupbox:AddToggle("Showtitle", {
	Text = "Show Title",
	Default = false,
	Tooltip = "Shows esp title",
})
--[[ Toggles.ShowBox:OnChanged(function()
	__Variables[selected] = Toggles.ShowBox.Value
end) ]]

Toggles.Showtitle:OnChanged(function()
	__Variables[selected .. "title"] = Toggles.Showtitle.Value
end)

Options.SelectOre:OnChanged(function()
	selected = Options.SelectOre.Value
	local title = __Variables[selected .. "title"] -- quick fix
	--[[ local box = __Variables[selected] -- quick fix ]]
	Toggles.Showtitle:SetValue(title)
	--[[ Toggles.ShowBox:SetValue(box) ]]
end)


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
lib:Notify("Made by Zeta")
