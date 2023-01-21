-- Fixed by squares (thanks) | L devs
local zlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zet-a/RobIox/main/LibrarySnippet.lua"))()
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/Library.lua"))()
local rocks = workspace.World.RockRegions.Island
local selected = "Mythril"
local ores = {
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
}

local function addOre(ore)
	if ore:IsA("MeshPart") then
		for i, v in pairs(ores) do
			for o, b in pairs(v) do
				if tostring(ore.MeshId) == o then
					zlib:box(ore.Parent.Parent, i, {
						Color = b.Color,
					})
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
}

local mainleftgroupbox = Tabs.Main:AddLeftGroupbox("Automatic stuff")
mainleftgroupbox:AddDropdown("SelectOre", {
	Values = { "Mythril", "Gold", "Iron", "Pyrite", "Tin", "Copper" },
	Default = 1,
	Multi = false,
	Text = "Ores",
	Tooltip = "Click the type of ore to show edit its title or box visibility.",
})
mainleftgroupbox:AddToggle("ShowBox", {
	Text = "Show Box",
	Default = false,
	Tooltip = "Shows esp box",
})
mainleftgroupbox:AddToggle("Showtitle", {
	Text = "Show Title",
	Default = false,
	Tooltip = "Shows esp title",
})
Toggles.ShowBox:OnChanged(function()
	__Variables[selected] = Toggles.ShowBox.Value
end)

Toggles.Showtitle:OnChanged(function()
	__Variables[selected .. "title"] = Toggles.Showtitle.Value
end)

Options.SelectOre:OnChanged(function()
	selected = Options.SelectOre.Value
	local title = __Variables[selected .. "title"] -- quick fix
	local box = __Variables[selected] -- quick fix
	Toggles.Showtitle:SetValue(title)
	Toggles.ShowBox:SetValue(box)
end)
