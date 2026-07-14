print('start created')

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Robote1122/bss_script/refs/heads/main/library.lua',true))()
local api = loadstring(game:HttpGet('https://raw.githubusercontent.com/Robote1122/bss_script/refs/heads/main/api.lua',true))()

if not isfolder("mve") then makefolder("mve") end
--[[
if isfile('mve_c.txt') == false then (syn and syn.request or http_request)({ Url = "http://127.0.0.1:6463/rpc?v=1",Method = "POST",Headers = {["Content-Type"] = "application/json",["Origin"] = "https://discord.com"},Body = game:GetService("HttpService"):JSONEncode({cmd = "INVITE_BROWSER",args = {code = ""},nonce = game:GetService("HttpService"):GenerateGUID(false)}),writefile('mve_c.txt', "discord")})end
]]
local playerstatsevent = game:GetService("ReplicatedStorage").Events.RetrievePlayerStats
local statstable = playerstatsevent:InvokeServer()
local monsterspawners = game:GetService("Workspace").MonsterSpawners
local rarename

function rtsg() tab = game.ReplicatedStorage.Events.RetrievePlayerStats:InvokeServer() return tab end
function maskequip(mask) local ohString1 = "Equip" local ohTable2 = { ["Mute"] = false, ["Type"] = mask, ["Category"] = "Accessory"} game:GetService("ReplicatedStorage").Events.ItemPackageEvent:InvokeServer(ohString1, ohTable2) end
local lasttouched = nil
local done = true
local hi = false
local Items = require(game:GetService("ReplicatedStorage").EggTypes).GetTypes()

hives = game.Workspace.Honeycombs:GetChildren() for i = #hives, 1, -1 do  v = game.Workspace.Honeycombs:GetChildren()[i] if v.Owner.Value == nil then game.ReplicatedStorage.Events.ClaimHive:FireServer(v.HiveID.Value) end end

local temptable = {
    version = "3.0.2",
    blackfield = "Sunflower Field",
    redfields = {},
    bluefields = {},
    whitefields = {},
    shouldiconvertballoonnow = false,
    balloondetected = false,
    puffshroomdetected = false,
    magnitude = 70,
    blacklist = {
        ""
    },
    running = false,
    configname = "",
    tokenpath = game:GetService("Workspace").Collectibles,
    started = {
        vicious = false,
        mondo = false,
        windy = false,
        ant = false,
        monsters = false
    },
    detected = {
        vicious = false,
        windy = false
    },
    tokensfarm = false,
    converting = false,
    honeystart = 0,
    grib = nil,
    gribpos = CFrame.new(0,0,0),
    honeycurrent = statstable.Totals.Honey,
    dead = false,
    float = false,
    pepsigodmode = false,
    pepsiautodig = false,
    alpha = false,
    beta = false,
    myhiveis = false,
    invis = false,
    windy = nil,
    sprouts = {
        detected = false,
        coords
    },
    cache = {
        autofarm = false,
        killmondo = false,
        vicious = false,
        windy = false
    },
    allplanters = {},
    planters = {
        planter = {},
        cframe = {},
        activeplanters = {
            type = {},
            id = {}
        }
    },
    monstertypes = {"Ladybug", "Rhino", "Spider", "Scorpion", "Mantis", "Werewolf"},
    ["stopapypa"] = function(path, part)
        local Closest
        for i,v in next, path:GetChildren() do
            if v.Name ~= "PlanterBulb" then
                if Closest == nil then
                    Closest = v.Soil
                else
                    if (part.Position - v.Soil.Position).magnitude < (Closest.Position - part.Position).magnitude then
                        Closest = v.Soil
                    end
                end
            end
        end
        return Closest
    end,
    coconuts = {},
    crosshairs = {},
    crosshair = false,
    coconut = false,
    act = 0,
    ['touchedfunction'] = function(v)
        if lasttouched ~= v then
            if v.Parent.Name == "FlowerZones" then
                if v:FindFirstChild("ColorGroup") then
                    if tostring(v.ColorGroup.Value) == "Red" then
                        maskequip("Demon Mask")
                    elseif tostring(v.ColorGroup.Value) == "Blue" then
                        maskequip("Diamond Mask")
                    end
                else
                    maskequip("Gummy Mask")
                end
                lasttouched = v
            end
        end
    end,
    runningfor = 0,
    oldtool = rtsg()["EquippedCollector"],
    ['gacf'] = function(part, st)
        coordd = CFrame.new(part.Position.X, part.Position.Y+st, part.Position.Z)
        return coordd
    end
}

local planterst = {
    plantername = {},
    planterid = {}
}

for i,v in next, game:GetService("Workspace").MonsterSpawners:GetDescendants() do if v.Name == "TimerAttachment" then v.Name = "Attachment" end end
for i,v in next, game:GetService("Workspace").MonsterSpawners:GetChildren() do if v.Name == "RoseBush" then v.Name = "ScorpionBush" elseif v.Name == "RoseBush2" then v.Name = "ScorpionBush2" end end
for i,v in next, game:GetService("Workspace").FlowerZones:GetChildren() do if v:FindFirstChild("ColorGroup") then if v:FindFirstChild("ColorGroup").Value == "Red" then table.insert(temptable.redfields, v.Name) elseif v:FindFirstChild("ColorGroup").Value == "Blue" then table.insert(temptable.bluefields, v.Name) end else table.insert(temptable.whitefields, v.Name) end end
local flowertable = {}
for _,z in next, game:GetService("Workspace").Flowers:GetChildren() do table.insert(flowertable, z.Position) end
local masktable = {}
for _,v in next, game:GetService("ReplicatedStorage").Accessories:GetChildren() do if string.match(v.Name, "Mask") then table.insert(masktable, v.Name) end end
local collectorstable = {}
for _,v in next, getupvalues(require(game:GetService("ReplicatedStorage").Collectors).Exists) do for e,r in next, v do table.insert(collectorstable, e) end end
local fieldstable = {}
for _,v in next, game:GetService("Workspace").FlowerZones:GetChildren() do table.insert(fieldstable, v.Name) end
local toystable = {}
for _,v in next, game:GetService("Workspace").Toys:GetChildren() do table.insert(toystable, v.Name) end
local spawnerstable = {}
for _,v in next, game:GetService("Workspace").MonsterSpawners:GetChildren() do table.insert(spawnerstable, v.Name) end
local accesoriestable = {}
for _,v in next, game:GetService("ReplicatedStorage").Accessories:GetChildren() do if v.Name ~= "UpdateMeter" then table.insert(accesoriestable, v.Name) end end
for i,v in pairs(getupvalues(require(game:GetService("ReplicatedStorage").PlanterTypes).GetTypes)) do for e,z in pairs(v) do table.insert(temptable.allplanters, e) end end
local donatableItemsTable = {}
local treatsTable = {}
for i,v in pairs(Items) do
    if v.DonatableToWindShrine == true then
        table.insert(donatableItemsTable,i)
    end
end

for i,v in pairs(Items) do
    if v.TreatValue then
        table.insert(treatsTable,i)
    end
end

local buffTable = {
    "Blue Extract";
    "Red Extract";
    "Oil";
    "Enzymes";
    "Glue";
    "Glitter";
    "Tropical Drink";
}

table.sort(fieldstable)
table.sort(accesoriestable)
table.sort(toystable)
table.sort(spawnerstable)
table.sort(masktable)
table.sort(temptable.allplanters)
table.sort(collectorstable)
table.sort(donatableItemsTable)
table.sort(buffTable)

-- float pad

local floatpad = Instance.new("Part", game:GetService("Workspace"))
floatpad.CanCollide = false
floatpad.Anchored = true
floatpad.Transparency = 1
floatpad.Name = "FloatPad"

-- cococrab

local cocopad = Instance.new("Part", game:GetService("Workspace"))
cocopad.Name = "Coconut Part"
cocopad.Anchored = true
cocopad.Transparency = 1
cocopad.Size = Vector3.new(10, 1, 10)
cocopad.Position = Vector3.new(-307.52117919922, 105.91863250732, 467.86791992188)

-- antfarm

local antpart = Instance.new("Part", workspace)
antpart.Name = "Ant Autofarm Part"
antpart.Position = Vector3.new(96, 47, 553)
antpart.Anchored = true
antpart.Size = Vector3.new(128, 1, 50)
antpart.Transparency = 1
antpart.CanCollide = false

-- config

local config = {
    rares = {},
    priority = {},
    bestfields = {
        red = "Pepper Patch",
        white = "Coconut Field",
        blue = "Stump Field"
    },
    blacklistedfields = {},
    killerconfig = {},
    bltokens = {},
    toggles = {
        autofarm = false,
        farmclosestleaf = false,
        farmbubbles = false,
        autodig = false,
        farmrares = false,
        rgbui = false,
        farmflower = false,
        farmfuzzy = false,
        farmcoco = false,
        farmflame = false,
        farmclouds = false,
        killmondo = false,
        killvicious = false,
        loopspeed = false,
        loopjump = false,
        autoquest = false,
        autoboosters = false,
        autodispense = false,
        clock = false,
        freeantpass = false,
        honeystorm = false,
        autodoquest = false,
        disableseperators = false,
        npctoggle = false,
        loopfarmspeed = false,
        mobquests = false,
        traincrab = false,
        avoidmobs = false,
        farmsprouts = false,
        enabletokenblacklisting = false,
        farmunderballoons = false,
        farmsnowflakes = false,
        collectgingerbreads = false,
        collectcrosshairs = false,
        farmpuffshrooms = false,
        tptonpc = false,
        donotfarmtokens = false,
        convertballoons = false,
        autostockings = false,
        autosamovar = false,
        autoonettart = false,
        autocandles = false,
        autofeast = false,
        autoplanters = false,
        autokillmobs = false,
        autoant = false,
        killwindy = false,
        godmode = false,
        disableconversion = false,
        autodonate = false,
    },
    vars = {
        field = "Ant Field",
        convertat = 100,
        farmspeed = 60,
        prefer = "Tokens",
        walkspeed = 70,
        jumppower = 70,
        npcprefer = "All Quests",
        farmtype = "Walk",
        monstertimer = 3,
        autodigmode = "Normal",
        donoItem = "Coconut",
        donoAmount = 25,
        selectedTreat = "Treat",
        selectedTreatAmount = 0,
    },
    dispensesettings = {
        blub = false,
        straw = false,
        treat = false,
        coconut = false,
        glue = false,
        rj = false,
        white = false,
        red = false,
        blue = false
    }
}

local defaultconfig = config


local win = library:CreateWindow({
	WindowName = "MVE 0.1",
	Color = Color3.fromRGB(164, 84, 255)
}, game:GetService("CoreGui"))

function statsget() local StatCache = require(game.ReplicatedStorage.ClientStatCache) local stats = StatCache:Get() return stats end

function farm(trying)
    if config.toggles.loopfarmspeed then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = config.vars.farmspeed end
    api.humanoid():MoveTo(trying.Position) 
    repeat task.wait() until (trying.Position-api.humanoidrootpart().Position).magnitude <=4 or not IsToken(trying) or not temptable.running
end

function disableall()
    if config.toggles.autofarm and not temptable.converting then
        temptable.cache.autofarm = true
        config.toggles.autofarm = false
    end
    if config.toggles.killmondo and not temptable.started.mondo then
        config.toggles.killmondo = false
        temptable.cache.killmondo = true
    end
    if config.toggles.killvicious and not temptable.started.vicious then
        config.toggles.killvicious = false
        temptable.cache.vicious = true
    end
    if config.toggles.killwindy and not temptable.started.windy then
        config.toggles.killwindy = false
        temptable.cache.windy = true
    end
end

function enableall()
    if temptable.cache.autofarm then
        config.toggles.autofarm = true
        temptable.cache.autofarm = false
    end
    if temptable.cache.killmondo then
        config.toggles.killmondo = true
        temptable.cache.killmondo = false
    end
    if temptable.cache.vicious then
        config.toggles.killvicious = true
        temptable.cache.vicious = false
    end
    if temptable.cache.windy then
        config.toggles.killwindy = true
        temptable.cache.windy = false
    end
end

local AllTokens = game.Workspace.Collectibles

local spawned_tokens = {}

local DecalsId={
	[1839454544]="GummybeeMore",
	[1104415222]="TabbyScratch",
	[2499514197]="ConvertMark",
	[1442764904]="BombPlus",
	[2499540966]="TabbyScratch",
	[253828517]="Melody",

	[65867881]="Hasty",
	[4519549299]="SpiceAbil",
	[1472256444]="BabyLove",
	[8083436978]="Balloon",
	[1442863423]="BlueBoost",
	[8083943936]="Surprize",

	[1874564120]="Pulse",
	[4528414666]="Table",
	[4528379338]="Syntez",
	[1472135114]="Honey",
	[2028574353]="Treat",
	[6087969886]="Snow",

	[1442725244]="Bomb",
	[1629547638]="TokenLink",
	[2000457501]="Inspire",
	[1629649299]="Look",
	[2319083910]="Spike",
	[1442700745]="Rage",
	
	[1472425802]="BrownBearMorph",
	[1472532912]="PolarBearMorph",
	[1472580249]="PandaBearMorph",
	[177997841]="GummybeeOne",
	[4889322534]="FuzzyBomb",
	[4519523935]="VectorTrig",
	
	[2028453802]="Blueberry",
	[1471882621]="RoyalJelly",
	[1952796032]="Pineapple",
	[1952682401]="SunflowerSeed",
	[4889470194]="GiftField",
	[1472491940]="BlackBearMorph",
	
	
	[1874692303]="BlueSyntez",
	[10000000000000]="dddd",
	[10000000000000]="dddd",
	[10000000000000]="dddd",
	[10000000000000]="dddd",
	[10000000000000]="dddd",
}

local FullDecalsId={}
local SmallDecalsId={}

spawn(function()
	for i,v in pairs(DecalsId) do
		SmallDecalsId["rbxassetid://"..i]=v
		FullDecalsId["http://www.roblox.com/asset/?id="..i]=v
	end
end)

AllTokens.ChildAdded:Connect(function(child)
	local FrontDecal = child:WaitForChild("FrontDecal")
	child.Name=SmallDecalsId[FrontDecal.Texture] or FullDecalsId[FrontDecal.Texture] or "C"
	if child.Name=="C" then
		print(FrontDecal.Texture,nil)
	end

    spawned_tokens[child]={token=child,spawned=os.clock(),name=child.Name}
end)

AllTokens.ChildRemoved:Connect(function(child)
	local FrontDecal = child:WaitForChild("FrontDecal")
	child.Name=SmallDecalsId[FrontDecal.Texture] or FullDecalsId[FrontDecal.Texture] or "C"
	if child.Name!="C" then
		print(FrontDecal.Texture,nil)
	end
    if not spawned_tokens[child] return end
    print(spawned_tokens[child].Name,os.clock()-spawned_tokens[child].spawned)
end)

print(acces_key)