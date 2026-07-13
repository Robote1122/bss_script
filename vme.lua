local cheat_name = 'nvm'

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Robote1122/bss_script/refs/heads/main/library.lua'))()
local api = loadstring(game:HttpGet('https://raw.githubusercontent.com/Robote1122/bss_script/refs/heads/main/api.lua'))()

print('start created')
-- Создаём основное окно
local Window = library:CreateWindow({
    WindowName = "Kocmoc v3.0.2 Remastered",
    Color = Color3.fromRGB(164, 84, 255)
}, game:GetService("CoreGui"))

-- ============================================
-- СОЗДАНИЕ ВКЛАДОК
-- ============================================

local hometab = Window:CreateTab("Home")
local farmtab = Window:CreateTab("Farming")
local combtab = Window:CreateTab("Combat")
local wayptab = Window:CreateTab("Waypoints")
local itemstab = Window:CreateTab("Items")
local misctab = Window:CreateTab("Misc")
local extrtab = Window:CreateTab("Extra")
local setttab = Window:CreateTab("Settings")

-- ============================================
-- ВКЛАДКА "HOME"
-- ============================================

local information = hometab:CreateSection("Information")

information:CreateLabel("Welcome, " .. game.Players.LocalPlayer.Name .. "!")
information:CreateLabel("Script version: 3.0.2")
information:CreateLabel("Place version: " .. game.PlaceVersion)
information:CreateLabel("Script by Boxking776")
information:CreateLabel("Originally by weuz_ and mrdevl")

local gainedhoneylabel = information:CreateLabel("Gained Honey: 0")

information:CreateButton("Discord Invite", function()
    setclipboard("https://discord.gg/kTNMzbxUuZ")
end)

information:CreateButton("Donation", function()
    setclipboard("https://www.paypal.com/paypalme/GHubPay")
end)

information:CreateLabel("")
information:CreateLabel("The script will continue to be updated")
information:CreateLabel("under new ownership.")
information:CreateLabel("")

-- ============================================
-- ВКЛАДКА "Farming"
-- ============================================

local farmo = farmtab:CreateSection("Farming")

local fielddropdown = farmo:CreateDropdown("Field", {"Sunflower Field", "Stump Field", "Coconut Field", "Pepper Patch", "Ant Field", "Mushroom Field", "Pineapple Patch", "Clover Field"}, function(String)
    _G.selectedField = String
end)
fielddropdown:SetOption("Sunflower Field")

local convertatslider = farmo:CreateSlider("Convert At", 0, 100, 100, false, function(Value)
    _G.convertAt = Value
end)

local autofarmtoggle = farmo:CreateToggle("Autofarm", nil, function(State)
    _G.autofarm = State
end)
autofarmtoggle:CreateKeybind("U", function(Key) end)

farmo:CreateToggle("Autodig", nil, function(State)
    _G.autodig = State
end)

farmo:CreateDropdown("Autodig Mode", {"Normal", "Collector Steal"}, function(Option)
    _G.autodigMode = Option
end)

farmo:CreateToggle("Don't Convert Pollen", nil, function(State)
    _G.disableConversion = State
end)

farmo:CreateToggle("Auto Sprinkler", nil, function(State)
    _G.autoSprinkler = State
end)

farmo:CreateToggle("Farm Bubbles", nil, function(State)
    _G.farmBubbles = State
end)

farmo:CreateToggle("Farm Flames", nil, function(State)
    _G.farmFlames = State
end)

farmo:CreateToggle("Farm Coconuts & Shower", nil, function(State)
    _G.farmCoconuts = State
end)

farmo:CreateToggle("Farm Precise Crosshairs", nil, function(State)
    _G.collectCrosshairs = State
end)

farmo:CreateToggle("Farm Fuzzy Bombs", nil, function(State)
    _G.farmFuzzy = State
end)

farmo:CreateToggle("Farm Under Balloons", nil, function(State)
    _G.farmUnderBalloons = State
end)

farmo:CreateToggle("Farm Under Clouds", nil, function(State)
    _G.farmClouds = State
end)

-- Вторая секция Farming
local farmt = farmtab:CreateSection("Farming Tools")

farmt:CreateToggle("Auto Dispenser", nil, function(State)
    _G.autoDispenser = State
end)

farmt:CreateToggle("Auto Field Boosters", nil, function(State)
    _G.autoBoosters = State
end)

farmt:CreateToggle("Auto Wealth Clock", nil, function(State)
    _G.wealthClock = State
end)

farmt:CreateToggle("Auto Gingerbread Bears", nil, function(State)
    _G.gingerbreadBears = State
end)

farmt:CreateToggle("Auto Samovar", nil, function(State)
    _G.autoSamovar = State
end)

farmt:CreateToggle("Auto Stockings", nil, function(State)
    _G.autoStockings = State
end)

farmt:CreateToggle("Auto Planters", nil, function(State)
    _G.autoPlanters = State
end):AddToolTip("Will re-plant your planters after converting, if they hit 100%")

farmt:CreateToggle("Auto Honey Candles", nil, function(State)
    _G.autoCandles = State
end)

farmt:CreateToggle("Auto Beesmas Feast", nil, function(State)
    _G.autoFeast = State
end)

farmt:CreateToggle("Auto Onett's Lid Art", nil, function(State)
    _G.autoOnettArt = State
end)

farmt:CreateToggle("Auto Free Antpasses", nil, function(State)
    _G.freeAntpass = State
end)

farmt:CreateToggle("Farm Sprouts", nil, function(State)
    _G.farmSprouts = State
end)

farmt:CreateToggle("Farm Puffshrooms", nil, function(State)
    _G.farmPuffshrooms = State
end)

farmt:CreateToggle("Farm Snowflakes", nil, function(State)
    _G.farmSnowflakes = State
end):AddToolTip("⚠️ - Not Safe Function")

farmt:CreateToggle("Teleport To Rares", nil, function(State)
    _G.farmRares = State
end):AddToolTip("⚠️ - Not Safe Function")

farmt:CreateToggle("Auto Accept/Confirm Quests", nil, function(State)
    _G.autoQuest = State
end)

farmt:CreateToggle("Auto Do Quests", nil, function(State)
    _G.autoDoQuest = State
end)

farmt:CreateToggle("Auto Honeystorm", nil, function(State)
    _G.honeystorm = State
end)

print('ppp')

-- ============================================
-- ВКЛАДКА "Combat"
-- ============================================

local mobkill = combtab:CreateSection("Combat")

mobkill:CreateToggle("Train Crab", nil, function(State)
    if State then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-307.521, 107.918, 467.867)
    end
end)

mobkill:CreateToggle("Train Snail", nil, function(State)
    local fd = game.Workspace.FlowerZones['Stump Field']
    if State then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(fd.Position.X, fd.Position.Y-6, fd.Position.Z)
    else
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(fd.Position.X, fd.Position.Y+2, fd.Position.Z)
    end
end)

mobkill:CreateToggle("Kill Mondo", nil, function(State)
    _G.killMondo = State
end)

mobkill:CreateToggle("Kill Vicious", nil, function(State)
    _G.killVicious = State
end)

mobkill:CreateToggle("Kill Windy", nil, function(State)
    _G.killWindy = State
end)

mobkill:CreateToggle("Auto Kill Mobs", nil, function(State)
    _G.autoKillMobs = State
end):AddToolTip("Kills mobs after x pollen converting")

mobkill:CreateToggle("Avoid Mobs", nil, function(State)
    _G.avoidMobs = State
end)

mobkill:CreateToggle("Auto Ant", nil, function(State)
    _G.autoAnt = State
end):AddToolTip("You Need Spark Staff; Goes to Ant Challenge after pollen converting")

-- Serverhopping секция
local serverhopkill = combtab:CreateSection("Serverhopping Combat")

serverhopkill:CreateButton("Vicious Bee Serverhopper", function()
    print("Vicious Bee Serverhopper - loadstring here")
end):AddToolTip("Serverhops for rouge vicious bees")

serverhopkill:CreateButton("Windy Bee Serverhopper", function()
    print("Windy Bee Serverhopper - loadstring here")
end):AddToolTip("Serverhops for wild windy bees")

serverhopkill:CreateLabel("")
serverhopkill:CreateLabel("[⚠️] These functions will unload the UI")
serverhopkill:CreateLabel("")

-- Auto Kill Mobs Settings
local amks = combtab:CreateSection("Auto Kill Mobs Settings")

amks:CreateTextBox("Kill Mobs After x Convertions", "default = 3", true, function(Value)
    _G.monsterTimer = tonumber(Value)
end)

-- ============================================
-- ВКЛАДКА "Waypoints"
-- ============================================

local wayp = wayptab:CreateSection("Waypoints")

wayp:CreateDropdown("Field Teleports", {"Sunflower Field", "Stump Field", "Coconut Field", "Pepper Patch", "Ant Field"}, function(Option)
    local field = game:GetService("Workspace").FlowerZones:FindFirstChild(Option)
    if field then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = field.CFrame
    end
end)

wayp:CreateDropdown("Monster Teleports", {"Mondo", "Coconut Crab", "Stump Snail"}, function(Option)
    print("Teleport to:", Option)
end)

wayp:CreateDropdown("Toys Teleports", {"Ant Challenge", "Samovar", "Stockings"}, function(Option)
    print("Teleport to:", Option)
end)

wayp:CreateButton("Teleport to hive", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.SpawnPos.Value
end)

-- ============================================
-- ВКЛАДКА "Items"
-- ============================================

local useitems = itemstab:CreateSection("Use Items")

useitems:CreateButton("Use All Buffs", function()
    local buffs = {"Blue Extract", "Red Extract", "Oil", "Enzymes", "Glue", "Glitter", "Tropical Drink"}
    for _, buff in pairs(buffs) do
        game:GetService("ReplicatedStorage").Events.PlayerActivesCommand:FireServer({["Name"] = buff})
        task.wait(0.1)
    end
end):AddToolTip("⚠️ - Not Safe Function")

useitems:CreateLabel("")

-- Создаём кнопки для каждого баффа
local buffs = {"Blue Extract", "Red Extract", "Oil", "Enzymes", "Glue", "Glitter", "Tropical Drink"}
for _, buff in pairs(buffs) do
    useitems:CreateButton("Use " .. buff, function()
        game:GetService("ReplicatedStorage").Events.PlayerActivesCommand:FireServer({["Name"] = buff})
    end)
end

-- Auto Feed секция
local autofeed = itemstab:CreateSection("Auto Feed")

autofeed:CreateDropdown("Select Treat", {"Treat", "Sunflower Seed", "Pineapple", "Blueberry"}, function(option)
    _G.selectedTreat = option
end)

autofeed:CreateTextBox("Treat Amount", "10", false, function(Value)
    _G.treatAmount = tonumber(Value)
end)

autofeed:CreateButton("Feed All Bees", function()
    print("Feeding all bees with:", _G.selectedTreat, _G.treatAmount)
end)

-- Wind Shrine секция
local windShrine = itemstab:CreateSection("Wind Shrine")

windShrine:CreateDropdown("Select Item", {"Coconut", "Strawberry", "Blueberry", "Glue", "Royal Jelly"}, function(Option)
    _G.donoItem = Option
end)

windShrine:CreateTextBox("Item Quantity", "10", false, function(Value)
    _G.donoAmount = tonumber(Value)
end)

windShrine:CreateButton("Donate", function()
    print("Donating:", _G.donoItem, _G.donoAmount)
end)

windShrine:CreateToggle("Auto Donate", nil, function(selection)
    _G.autoDonate = selection
end)

-- ============================================
-- ВКЛАДКА "Misc"
-- ============================================

local miscc = misctab:CreateSection("Misc")

miscc:CreateButton("Ant Challenge Semi-Godmode", function()
    print("Ant Challenge Semi-Godmode activated")
end)

local wstoggle = miscc:CreateToggle("Walk Speed", nil, function(State)
    _G.loopSpeed = State
end)
wstoggle:CreateKeybind("K", function(Key) end)

local jptoggle = miscc:CreateToggle("Jump Power", nil, function(State)
    _G.loopJump = State
end)
jptoggle:CreateKeybind("L", function(Key) end)

miscc:CreateToggle("Godmode", nil, function(State)
    _G.godmode = State
    if State then
        game.Players.LocalPlayer.Character.Humanoid.MaxHealth = math.huge
        game.Players.LocalPlayer.Character.Humanoid.Health = math.huge
    else
        game.Players.LocalPlayer.Character.Humanoid.MaxHealth = 100
    end
end)

-- Other секция
local misco = misctab:CreateSection("Other")

misco:CreateDropdown("Equip Accessories", {"Demon Mask", "Diamond Mask", "Gummy Mask", "Fire Mask", "Bubble Mask"}, function(Option)
    local ohString1 = "Equip"
    local ohTable2 = {
        ["Mute"] = false,
        ["Type"] = Option,
        ["Category"] = "Accessory"
    }
    game:GetService("ReplicatedStorage").Events.ItemPackageEvent:InvokeServer(ohString1, ohTable2)
end)

misco:CreateDropdown("Equip Masks", {"Demon Mask", "Diamond Mask", "Gummy Mask", "Fire Mask", "Bubble Mask"}, function(Option)
    local ohString1 = "Equip"
    local ohTable2 = {
        ["Mute"] = false,
        ["Type"] = Option,
        ["Category"] = "Accessory"
    }
    game:GetService("ReplicatedStorage").Events.ItemPackageEvent:InvokeServer(ohString1, ohTable2)
end)

misco:CreateDropdown("Equip Collectors", {"Porcelain Dipper", "Spark Staff", "Petal Wand", "Gummyballer"}, function(Option)
    local ohString1 = "Equip"
    local ohTable2 = {
        ["Mute"] = false,
        ["Type"] = Option,
        ["Category"] = "Collector"
    }
    game:GetService("ReplicatedStorage").Events.ItemPackageEvent:InvokeServer(ohString1, ohTable2)
end)

misco:CreateDropdown("Generate Amulet", {"Supreme Star Amulet", "Diamond Star Amulet", "Gold Star Amulet", "Silver Star Amulet", "Bronze Star Amulet", "Moon Amulet"}, function(Option)
    local A_1 = Option .. " Generator"
    local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
    Event:FireServer(A_1)
end)

misco:CreateButton("Export Stats Table", function()
    print("Stats exported!")
end)

-- ============================================
-- ВКЛАДКА "Extra"
-- ============================================

local extras = extrtab:CreateSection("Extras")

extras:CreateButton("Boost FPS", function()
    print("FPS Boost - loadstring here")
end)

extras:CreateButton("Destroy Decals", function()
    for i, v in pairs(game:GetDescendants()) do
        if v:IsA("Decal") then
            v:Destroy()
        end
    end
end)

extras:CreateTextBox("Glider Speed", "", true, function(Value)
    print("Glider Speed set to:", Value)
end)

extras:CreateTextBox("Glider Float", "", true, function(Value)
    print("Glider Float set to:", Value)
end)

extras:CreateButton("Invisibility", function()
    print("Invisibility activated")
end)

extras:CreateToggle("Float", nil, function(State)
    _G.floatMode = State
end)

-- ============================================
-- ВКЛАДКА "Settings"
-- ============================================

local farmsettings = setttab:CreateSection("Autofarm Settings")

farmsettings:CreateTextBox("Autofarming Walkspeed", "Default Value = 60", true, function(Value)
    _G.farmSpeed = tonumber(Value)
end)

farmsettings:CreateToggle("Loop Speed On Autofarming", nil, function(State)
    _G.loopFarmSpeed = State
end)

farmsettings:CreateToggle("Don't Walk In Field", nil, function(State)
    _G.farmFlower = State
end)

farmsettings:CreateToggle("Convert Hive Balloon", nil, function(State)
    _G.convertBalloons = State
end)

farmsettings:CreateToggle("Don't Farm Tokens", nil, function(State)
    _G.dontFarmTokens = State
end)

farmsettings:CreateToggle("Enable Token Blacklisting", nil, function(State)
    _G.enableTokenBlacklisting = State
end)

farmsettings:CreateSlider("Walk Speed", 0, 120, 70, false, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
end)

farmsettings:CreateSlider("Jump Power", 0, 120, 70, false, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
end)

-- Tokens Settings
local raresettings = setttab:CreateSection("Tokens Settings")

raresettings:CreateTextBox("Asset ID", "rbxassetid", false, function(Value)
    _G.rareName = Value
end)

raresettings:CreateButton("Add Token To Rares List", function()
    print("Added token to rares list")
end)

raresettings:CreateButton("Remove Token From Rares List", function()
    print("Removed token from rares list")
end)

raresettings:CreateButton("Add Token To Blacklist", function()
    print("Added token to blacklist")
end)

raresettings:CreateButton("Remove Token From Blacklist", function()
    print("Removed token from blacklist")
end)

raresettings:CreateDropdown("Tokens Blacklist", {}, function(Option) end)
raresettings:CreateDropdown("Rares List", {}, function(Option) end)

-- Auto Dispenser & Auto Boosters Settings
local dispsettings = setttab:CreateSection("Auto Dispenser & Auto Boosters Settings")

dispsettings:CreateToggle("Royal Jelly Dispenser", nil, function(State)
    _G.dispenserRJ = State
end)

dispsettings:CreateToggle("Blueberry Dispenser", nil, function(State)
    _G.dispenserBlue = State
end)

dispsettings:CreateToggle("Strawberry Dispenser", nil, function(State)
    _G.dispenserStraw = State
end)

dispsettings:CreateToggle("Treat Dispenser", nil, function(State)
    _G.dispenserTreat = State
end)

dispsettings:CreateToggle("Coconut Dispenser", nil, function(State)
    _G.dispenserCoconut = State
end)

dispsettings:CreateToggle("Glue Dispenser", nil, function(State)
    _G.dispenserGlue = State
end)

dispsettings:CreateToggle("Mountain Top Booster", nil, function(State)
    _G.boosterWhite = State
end)

dispsettings:CreateToggle("Blue Field Booster", nil, function(State)
    _G.boosterBlue = State
end)

dispsettings:CreateToggle("Red Field Booster", nil, function(State)
    _G.boosterRed = State
end)

-- GUI Settings
local guisettings = setttab:CreateSection("GUI Settings")

local uitoggle = guisettings:CreateToggle("UI Toggle", nil, function(State)
    Window:Toggle(State)
end)
uitoggle:CreateKeybind("Semicolon", function(Key) end)
uitoggle:SetState(true)

guisettings:CreateColorpicker("UI Color", function(Color)
    Window:ChangeColor(Color)
end)

local themes = guisettings:CreateDropdown("Image", {"Default", "Hearts", "Abstract", "Hexagon", "Circles", "Lace With Flowers", "Floral"}, function(Name)
    local images = {
        Default = "2151741365",
        Hearts = "6073763717",
        Abstract = "6073743871",
        Hexagon = "6073628839",
        Circles = "6071579801",
        ["Lace With Flowers"] = "6071575925",
        Floral = "5553946656"
    }
    Window:SetBackground(images[Name])
end)
themes:SetOption("Default")

-- Configs
local kocmocs = setttab:CreateSection("Configs")

kocmocs:CreateTextBox("Config Name", "ex: stumpconfig", false, function(Value)
    _G.configName = Value
end)

kocmocs:CreateButton("Load Config", function()
    print("Loading config:", _G.configName)
end)

kocmocs:CreateButton("Save Config", function()
    print("Saving config:", _G.configName)
end)

kocmocs:CreateButton("Reset Config", function()
    print("Config reset")
end)

-- Fields Settings
local fieldsettings = setttab:CreateSection("Fields Settings")

fieldsettings:CreateDropdown("Best White Field", {"Coconut Field", "Stump Field", "Pepper Patch"}, function(Option)
    _G.bestWhiteField = Option
end)

fieldsettings:CreateDropdown("Best Red Field", {"Pepper Patch", "Sunflower Field", "Mushroom Field"}, function(Option)
    _G.bestRedField = Option
end)

fieldsettings:CreateDropdown("Best Blue Field", {"Stump Field", "Pineapple Patch", "Ant Field"}, function(Option)
    _G.bestBlueField = Option
end)

fieldsettings:CreateDropdown("Field", {"Sunflower Field", "Stump Field", "Coconut Field"}, function(Option)
    _G.blackField = Option
end)

fieldsettings:CreateButton("Add Field To Blacklist", function()
    print("Added field to blacklist")
end)

fieldsettings:CreateButton("Remove Field From Blacklist", function()
    print("Removed field from blacklist")
end)

fieldsettings:CreateDropdown("Blacklisted Fields", {}, function(Option) end)

-- Auto Quest Settings
local aqs = setttab:CreateSection("Auto Quest Settings")

aqs:CreateDropdown("Do NPC Quests", {'All Quests', 'Bucko Bee', 'Brown Bear', 'Riley Bee', 'Polar Bear'}, function(Option)
    _G.npcPrefer = Option
end)

aqs:CreateToggle("Teleport To NPC", nil, function(State)
    _G.tpToNPC = State
end)

-- Autofarm Priority Tokens
local pts = setttab:CreateSection("Autofarm Priority Tokens")

pts:CreateTextBox("Asset ID", "rbxassetid", false, function(Value)
    _G.rareName = Value
end)

pts:CreateButton("Add Token To Priority List", function()
    print("Added token to priority list")
end)

pts:CreateButton("Remove Token From Priority List", function()
    print("Removed token from priority list")
end)

pts:CreateDropdown("Priority List", {}, function(Option) end)

-- ============================================
-- ОСНОВНАЯ ЛОГИКА
-- ============================================

-- Тут будет основной код фарма
task.spawn(function()
    while task.wait() do
        if _G.autofarm then
            -- Основная логика фарма
            -- ...
        end
    end
end)

-- Обновление счётчика мёда
task.spawn(function()
    local honeyStart = 0
    local statstable = game:GetService("ReplicatedStorage").Events.RetrievePlayerStats:InvokeServer()
    honeyStart = statstable.Totals.Honey
    
    while task.wait(1) do
        local stats = game:GetService("ReplicatedStorage").Events.RetrievePlayerStats:InvokeServer()
        local currentHoney = stats.Totals.Honey
        local gained = currentHoney - honeyStart
        gainedhoneylabel:UpdateText("Gained Honey: " .. string.format("%.0f", gained))
    end
end)

-- Авто-принятие квестов
game:GetService('RunService').Heartbeat:Connect(function()
    if _G.autoQuest then
        pcall(function()
            local npcButton = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("NPC")
            if npcButton then
                npcButton.ButtonOverlay.MouseButton1Click:Fire()
            end
        end)
    end
end)

print("GUI successfully loaded!")