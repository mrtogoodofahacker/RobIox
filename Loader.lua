local instances = {}
local menubtns = {}
local function new(instance,props,bl)
    local obj = Instance.new(instance)
    for property,value in next, props do
        obj[property] = value
    end
    if not bl then
        table.insert(instances,obj)
    end
    return obj
end

local function newbtn(name,parent)
    local e = new("TextButton",{
        Parent = parent,
        BackgroundColor3 = Color3.fromRGB(111,0,166),
        BorderColor3 = Color3.fromRGB(0,0,0),
        Size = UDim2.new(0,180,0,25),
        ZIndex = 2,
        Text = name,
        RichText = true,
        TextScaled = true,
        Visible = false,
        TextTransparency = 1,
        TextColor3 = Color3.fromRGB(0,0,0)
    },true)
    table.insert(menubtns, e)
    return e
end

local ProtectGui = protectgui or (syn and syn.protect_gui) or (function() end);
local repo = "https://raw.githubusercontent.com/Zet-a/RobIox/main/"
local games = {
    Oaklands = 9938675423,
}

local selected
local ts = game:GetService("TweenService")
local ti = TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local opensel = {Size = UDim2.new(0,190,0,100)}
local closesel = {Size = UDim2.new(0,190,0,0)}

local sg = Instance.new("ScreenGui")
sg.ZIndexBehavior = Enum.ZIndexBehavior.Global
ProtectGui(sg)

local mainframe = new("Frame",{
    Parent = sg,
    BackgroundColor3 = Color3.fromRGB(66, 0, 99),
    BorderColor3 = Color3.fromRGB(0,0,0),
    Size = UDim2.new(0, 200,0, 100),
    Position = UDim2.new(0.425, 0,0.438, 0),
})

local innerframe = new("Frame",{
    Parent = mainframe,
    BackgroundColor3 = Color3.fromRGB(66,0,99),
    BorderColor3 = Color3.fromRGB(0,0,0),
    Size = UDim2.new(0,200,0,80),
    Position = UDim2.new(0, 0,0.2, 0),
})

local title = new("TextLabel",{
    Parent = mainframe,
    BackgroundColor3 = Color3.fromRGB(111,0,166),
    BorderColor3 = Color3.fromRGB(0,0,0),
    Size = UDim2.new(0,200,0,20),
    ZIndex = 2,
    Text = "Obsidian Loader V1.0",
    TextScaled = true,
    RichText = true,
    TextColor3 = Color3.fromRGB(0,0,0)
})

local pattern = new("ImageLabel",{
    Parent = innerframe,
    Image = "rbxassetid://2151741365",
    ImageTransparency = 0.6,
})

local load = new("TextButton",{
    Parent = innerframe,
    BackgroundColor3 = Color3.fromRGB(111,0,166),
    BorderColor3 = Color3.fromRGB(0,0,0),
    Size = UDim2.new(0,190,0,20),
    Position = UDim2.new(0.025,0,0.25,0),
    Text = "Load",
    RichText = true,
    TextScaled = true,
    ZIndex = 2,
    TextColor3 = Color3.fromRGB(0,0,0)
})

local selmenu = new("TextButton",{
    Parent = innerframe,
    BackgroundColor3 = Color3.fromRGB(111,0,166),
    BorderColor3 = Color3.fromRGB(0,0,0),
    Size = UDim2.new(0,190,0,20),
    Position = UDim2.new(0.025,0,0.625,0),
    Text = "Select Menu",
    RichText = true,
    TextScaled = true,
    ZIndex = 2,
    TextColor3 = Color3.fromRGB(0,0,0)
})

local selectionframe = new("Frame",{
    Parent = selmenu,
    BackgroundColor3 = Color3.fromRGB(66,0,99),
    BorderColor3 = Color3.fromRGB(0,0,0),
    Size = UDim2.new(0,190,0,0),
    Position = UDim2.new(0,0,1,0),
    ZIndex = 2,
    Visible = false
},true)

local uip = new("UIPadding",{
    Parent = selectionframe,
    PaddingTop = UDim.new(0,5)
},true)

local Uill = new("UIListLayout",{
    Parent = selectionframe,
    Padding = UDim.new(0,5),
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
})

local uni = newbtn("Universal (Soon!)",selectionframe)

local toggle = true
local db = false
selmenu.MouseButton1Down:Connect(function()
    if db == false then
        db = true
        if toggle == true then
            selectionframe.Visible = true
            local t = ts:Create(selectionframe,ti,opensel)
            t:Play()
            t.Completed:Connect(function()
                for i,v in pairs(menubtns) do
                    v.Visible = true
                    local tabl = {
                        TextTransparency = 0,
                        Transparency = 0,
                    }
                    local e = ts:Create(v,ti,tabl)
                    e:Play()
                end
            end)
            toggle = false
        else
            for i,v in pairs(menubtns) do
                local tabl = {
                    TextTransparency = 1,
                    Transparency = 1,
                }
                local e = ts:Create(v,ti,tabl)
                e:Play()
                e.Completed:Connect(function()
                    v.Visible = false
                    local t = ts:Create(selectionframe,ti,closesel)
                    t:Play()
                    t.Completed:Connect(function()
                        selectionframe.Visible = false
                    end)
                end)
            end
            toggle = true
        end
        task.wait(0.5)
        db = false
    end
end)

for i,v in pairs(games) do
    if game.PlaceId == v then
        local gspecific = newbtn(tostring(i),selectionframe)
        gspecific.MouseButton1Down:Connect(function()
            selmenu.Text = tostring(i)
            selected = v
            for a,b in pairs(menubtns) do
                local tabl = {
                    TextTransparency = 1,
                    Transparency = 1,
                }
                local e = ts:Create(b,ti,tabl)
                e:Play()
                e.Completed:Connect(function()
                    b.Visible = false
                    local t = ts:Create(selectionframe,ti,closesel)
                    t:Play()
                    t.Completed:Connect(function()
                        selectionframe.Visible = false
                    end)
                end)
            end
        end)
    end
end

load.MouseButton1Down:Connect(function()
    if selected ~= nil or "" then
        loadstring(game:HttpGet(repo..tostring(selected)..".lua"))()
    else
        load.Text = "Menu not selected!"
        task.wait(1)
        load.Text = "Load"
    end
end)
