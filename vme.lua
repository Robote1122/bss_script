local cheat_name = 'nvm'

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Robote1122/bss_script/refs/heads/main/library.lua'))()
local api = loadstring(game:HttpGet('https://raw.githubusercontent.com/Robote1122/bss_script/refs/heads/main/api.lua'))()

-- Загружаем библиотеку
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/your/library.lua"))()

-- Создаём окно
local Window = Library:CreateWindow({
    WindowName = "My Awesome Script",
    Color = Color3.fromRGB(70, 100, 200)  -- Основной цвет
}, game.Players.LocalPlayer.PlayerGui)

-- Создаём вкладку
local MainTab = Window:CreateTab("Main")

-- Секция в главной вкладке
local SettingsSection = MainTab:CreateSection("Settings")

-- Кнопка
SettingsSection:CreateButton("Execute Script", function()
    print("Script executed!")
    -- Твой код
end)

-- Переключатель
local FarmToggle = SettingsSection:CreateToggle("Auto Farm", false, function(state)
    print("Farm enabled:", state)
    _G.AutoFarm = state
end)

-- Слайдер
SettingsSection:CreateSlider("Speed", 10, 200, 100, false, function(value)
    print("Speed set to:", value)
    _G.FarmSpeed = value
end)

-- Дропдаун
SettingsSection:CreateDropdown("Farm Mode", {"Normal", "Aggressive", "Safe"}, function(option)
    print("Selected mode:", option)
    _G.FarmMode = option
end, "Normal")  -- InitialValue

-- Текстовое поле
SettingsSection:CreateTextBox("Enter Key", "Type here...", false, function(value)
    print("Input:", value)
end)

-- Создаём вторую вкладку
local SettingsTab = Window:CreateTab("Settings")

local ConfigSection = SettingsTab:CreateSection("Config")

-- Кнопка сохранения
ConfigSection:CreateButton("Save Config", function()
    print("Config saved!")
end)

-- Кнопка загрузки
ConfigSection:CreateButton("Load Config", function()
    print("Config loaded!")
end)

-- Создаём третью вкладку
local ProfileTab = Window:CreateTab("Profile")

local InfoSection = ProfileTab:CreateSection("Player Info")

-- Метки (информационные поля)
local Label1 = InfoSection:CreateLabel("Player: " .. game.Players.LocalPlayer.Name)
local Label2 = InfoSection:CreateLabel("Level: 42")
local Label3 = InfoSection:CreateLabel("Honey: 1,234,567")