-- ============================================
-- MODERN UI LIBRARY v2.0
-- Стеклянный дизайн, минимализм, анимации
-- ============================================

local Library = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

-- Настройки темы
Library.Theme = {
    Background = Color3.fromRGB(20, 20, 30),
    Accent = Color3.fromRGB(100, 150, 255),
    Text = Color3.fromRGB(255, 255, 255),
    SecondaryText = Color3.fromRGB(180, 180, 190),
    ElementBg = Color3.fromRGB(255, 255, 255),
    ElementBgTransparency = 0.08,
    CornerRadius = 10,
    GlassBlur = true
}

-- === UTILITY FUNCTIONS ===

local function MakeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

local function CreateCorner(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or Library.Theme.CornerRadius)
    corner.Parent = instance
    return corner
end

local function CreateStroke(instance, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.fromRGB(255, 255, 255)
    stroke.Thickness = thickness or 1
    stroke.Transparency = 0.15
    stroke.Parent = instance
    return stroke
end

-- === MAIN WINDOW ===

function Library:CreateWindow(config)
    config = config or {}
    local windowName = config.Name or "Script Hub"
    local accentColor = config.Color or Library.Theme.Accent
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ModernUI_" .. HttpService:GenerateGUID(false)
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("CoreGui")
    
    -- Main Frame (glassmorphism)
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 600, 0, 450)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -225)
    mainFrame.BackgroundColor3 = Library.Theme.Background
    mainFrame.BackgroundTransparency = 0.15
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    CreateCorner(mainFrame, 12)
    CreateStroke(mainFrame, Color3.fromRGB(255, 255, 255), 1)
    
    -- Glass blur effect (if supported)
    if Library.Theme.GlassBlur then
        local blur = Instance.new("BlurEffect")
        blur.Size = 12
        blur.Parent = mainFrame
    end
    
    MakeDraggable(mainFrame)
    
    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 35)
    titleBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    titleBar.BackgroundTransparency = 0.05
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    CreateCorner(titleBar, 12)
    
    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(1, -40, 1, 0)
    titleText.Position = UDim2.new(0, 15, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = windowName
    titleText.TextColor3 = Library.Theme.Text
    titleText.TextSize = 16
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.FontFace = Font.fromName("GothamBold")
    titleText.Parent = titleBar
    
    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 25, 0, 25)
    closeBtn.Position = UDim2.new(1, -32, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.BackgroundTransparency = 0.3
    closeBtn.BorderSizePixel = 0
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 14
    closeBtn.FontFace = Font.fromName("GothamBold")
    closeBtn.Parent = titleBar
    CreateCorner(closeBtn, 6)
    
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- Tab Container (sidebar)
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(0, 160, 1, -35)
    tabContainer.Position = UDim2.new(0, 0, 0, 35)
    tabContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tabContainer.BackgroundTransparency = 0.05
    tabContainer.BorderSizePixel = 0
    tabContainer.Parent = mainFrame
    
    local tabList = Instance.new("UIListLayout")
    tabList.Padding = UDim.new(0, 4)
    tabList.FillDirection = Enum.FillDirection.Vertical
    tabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tabList.VerticalAlignment = Enum.VerticalAlignment.Top
    tabList.Parent = tabContainer
    
    -- Content Area
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -160, 1, -35)
    contentFrame.Position = UDim2.new(0, 160, 0, 35)
    contentFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    contentFrame.BackgroundTransparency = 0.03
    contentFrame.BorderSizePixel = 0
    contentFrame.Parent = mainFrame
    CreateCorner(contentFrame, 8)
    
    local contentList = Instance.new("UIListLayout")
    contentList.Padding = UDim.new(0, 8)
    contentList.FillDirection = Enum.FillDirection.Vertical
    contentList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    contentList.VerticalAlignment = Enum.VerticalAlignment.Top
    contentList.Parent = contentFrame
    
    -- Tooltip
    local tooltip = Instance.new("Frame")
    tooltip.Size = UDim2.new(0, 0, 0, 0)
    tooltip.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    tooltip.BackgroundTransparency = 0.1
    tooltip.BorderSizePixel = 0
    tooltip.Visible = false
    tooltip.Parent = screenGui
    CreateCorner(tooltip, 6)
    
    local tooltipText = Instance.new("TextLabel")
    tooltipText.Size = UDim2.new(1, -10, 1, -5)
    tooltipText.Position = UDim2.new(0, 5, 0, 2.5)
    tooltipText.BackgroundTransparency = 1
    tooltipText.Text = ""
    tooltipText.TextColor3 = Library.Theme.Text
    tooltipText.TextSize = 12
    tooltipText.FontFace = Font.fromName("Gotham")
    tooltipText.TextWrapped = true
    tooltipText.Parent = tooltip
    
    RunService.RenderStepped:Connect(function()
        if tooltip.Visible then
            local mouse = UserInputService:GetMouseLocation()
            tooltip.Position = UDim2.new(0, mouse.X + 12, 0, mouse.Y - 5)
        end
    end)
    
    -- === WINDOW METHODS ===
    
    local window = {
        _screen = screenGui,
        _main = mainFrame,
        _content = contentFrame,
        _contentList = contentList,
        _tabContainer = tabContainer,
        _tooltip = tooltip,
        _tooltipText = tooltipText,
        _tabs = {},
        _currentTab = nil,
        _accent = accentColor
    }
    
    function window:Destroy()
        screenGui:Destroy()
    end
    
    function window:Toggle(state)
        mainFrame.Visible = state
    end
    
    function window:ChangeColor(color)
        window._accent = color
        for _, tab in pairs(window._tabs) do
            if tab._button then
                tab._button.BackgroundColor3 = color
            end
        end
    end
    
    function window:SetBackground(imageId)
        -- Для фона можно использовать ImageLabel или просто прозрачность
    end
    
    function window:CreateTab(name)
        local tab = {}
        
        -- Tab Button
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 140, 0, 35)
        btn.BackgroundColor3 = window._accent
        btn.BackgroundTransparency = 0.6
        btn.BorderSizePixel = 0
        btn.Text = name
        btn.TextColor3 = Library.Theme.Text
        btn.TextSize = 14
        btn.FontFace = Font.fromName("GothamBold")
        btn.Parent = window._tabContainer
        CreateCorner(btn, 8)
        
        -- Tab Content
        local tabFrame = Instance.new("ScrollingFrame")
        tabFrame.Size = UDim2.new(1, -16, 1, -8)
        tabFrame.Position = UDim2.new(0, 8, 0, 4)
        tabFrame.BackgroundTransparency = 1
        tabFrame.BorderSizePixel = 0
        tabFrame.ScrollBarThickness = 4
        tabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabFrame.Visible = false
        tabFrame.Parent = window._content
        
        local tabList = Instance.new("UIListLayout")
        tabList.Padding = UDim.new(0, 8)
        tabList.FillDirection = Enum.FillDirection.Vertical
        tabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
        tabList.VerticalAlignment = Enum.VerticalAlignment.Top
        tabList.SortOrder = Enum.SortOrder.LayoutOrder
        tabList.Parent = tabFrame
        
        tabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabFrame.CanvasSize = UDim2.new(0, 0, 0, tabList.AbsoluteContentSize.Y + 10)
        end)
        
        tab._frame = tabFrame
        tab._list = tabList
        tab._button = btn
        tab._name = name
        
        btn.MouseButton1Click:Connect(function()
            for _, t in pairs(window._tabs) do
                t._frame.Visible = false
                t._button.BackgroundTransparency = 0.6
            end
            tabFrame.Visible = true
            btn.BackgroundTransparency = 0.2
            window._currentTab = tab
        end)
        
        table.insert(window._tabs, tab)
        
        -- Select first tab
        if #window._tabs == 1 then
            tabFrame.Visible = true
            btn.BackgroundTransparency = 0.2
            window._currentTab = tab
        end
        
        -- === TAB METHODS ===
        
        function tab:CreateSection(name)
            local section = {}
            
            local sectionFrame = Instance.new("Frame")
            sectionFrame.Size = UDim2.new(1, -4, 0, 0)
            sectionFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sectionFrame.BackgroundTransparency = 0.05
            sectionFrame.BorderSizePixel = 0
            sectionFrame.Parent = tab._frame
            CreateCorner(sectionFrame, 8)
            
            local sectionList = Instance.new("UIListLayout")
            sectionList.Padding = UDim.new(0, 4)
            sectionList.FillDirection = Enum.FillDirection.Vertical
            sectionList.HorizontalAlignment = Enum.HorizontalAlignment.Center
            sectionList.VerticalAlignment = Enum.VerticalAlignment.Top
            sectionList.Parent = sectionFrame
            
            local titleLabel = Instance.new("TextLabel")
            titleLabel.Size = UDim2.new(1, -12, 0, 25)
            titleLabel.Position = UDim2.new(0, 6, 0, 2)
            titleLabel.BackgroundTransparency = 1
            titleLabel.Text = name
            titleLabel.TextColor3 = Library.Theme.Text
            titleLabel.TextSize = 14
            titleLabel.TextXAlignment = Enum.TextXAlignment.Left
            titleLabel.FontFace = Font.fromName("GothamBold")
            titleLabel.Parent = sectionFrame
            
            local separator = Instance.new("Frame")
            separator.Size = UDim2.new(1, -12, 0, 1)
            separator.Position = UDim2.new(0, 6, 0, 28)
            separator.BackgroundColor3 = Library.Theme.Text
            separator.BackgroundTransparency = 0.2
            separator.BorderSizePixel = 0
            separator.Parent = sectionFrame
            
            section._frame = sectionFrame
            section._list = sectionList
            
            -- Update section height
            sectionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                sectionFrame.Size = UDim2.new(1, -4, 0, sectionList.AbsoluteContentSize.Y + 35)
            end)
            
            -- === ELEMENTS ===
            
            function section:CreateParagraph(text)
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -12, 0, 20)
                label.BackgroundTransparency = 1
                label.Text = text
                label.TextColor3 = Library.Theme.SecondaryText
                label.TextSize = 13
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.FontFace = Font.fromName("Gotham")
                label.Parent = section._frame
                
                return label
            end
            
            function section:CreateButton(config)
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, -12, 0, 32)
                btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                btn.BackgroundTransparency = 0.08
                btn.BorderSizePixel = 0
                btn.Text = config.Name or "Button"
                btn.TextColor3 = Library.Theme.Text
                btn.TextSize = 13
                btn.FontFace = Font.fromName("GothamBold")
                btn.Parent = section._frame
                CreateCorner(btn, 6)
                
                btn.MouseButton1Click:Connect(function()
                    if config.Callback then config.Callback() end
                end)
                
                -- Hover effect
                btn.MouseEnter:Connect(function()
                    TweenService:Create(btn, TweenInfo.new(0.2), {
                        BackgroundTransparency = 0.15
                    }):Play()
                end)
                btn.MouseLeave:Connect(function()
                    TweenService:Create(btn, TweenInfo.new(0.2), {
                        BackgroundTransparency = 0.08
                    }):Play()
                end)
                
                -- Tooltip
                if config.Tooltip then
                    btn.MouseEnter:Connect(function()
                        window._tooltipText.Text = config.Tooltip
                        window._tooltip.Size = UDim2.new(0, window._tooltipText.TextBounds.X + 12, 0, window._tooltipText.TextBounds.Y + 8)
                        window._tooltip.Visible = true
                    end)
                    btn.MouseLeave:Connect(function()
                        window._tooltip.Visible = false
                    end)
                end
                
                return btn
            end
            
            function section:CreateToggle(config)
                local toggle = {}
                local state = config.Default or false
                
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1, -12, 0, 32)
                frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                frame.BackgroundTransparency = 0.05
                frame.BorderSizePixel = 0
                frame.Parent = section._frame
                CreateCorner(frame, 6)
                
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -50, 1, 0)
                label.Position = UDim2.new(0, 8, 0, 0)
                label.BackgroundTransparency = 1
                label.Text = config.Name or "Toggle"
                label.TextColor3 = Library.Theme.Text
                label.TextSize = 13
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.FontFace = Font.fromName("Gotham")
                label.Parent = frame
                
                local toggleBtn = Instance.new("TextButton")
                toggleBtn.Size = UDim2.new(0, 30, 0, 18)
                toggleBtn.Position = UDim2.new(1, -38, 0, 7)
                toggleBtn.BackgroundColor3 = state and window._accent or Color3.fromRGB(60, 60, 70)
                toggleBtn.BackgroundTransparency = 0.15
                toggleBtn.BorderSizePixel = 0
                toggleBtn.Text = ""
                toggleBtn.Parent = frame
                CreateCorner(toggleBtn, 9)
                
                local indicator = Instance.new("Frame")
                indicator.Size = UDim2.new(0, 14, 0, 14)
                indicator.Position = state and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)
                indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                indicator.BackgroundTransparency = 0.2
                indicator.BorderSizePixel = 0
                indicator.Parent = toggleBtn
                CreateCorner(indicator, 7)
                
                local function setState(newState)
                    state = newState
                    toggleBtn.BackgroundColor3 = state and window._accent or Color3.fromRGB(60, 60, 70)
                    TweenService:Create(indicator, TweenInfo.new(0.2), {
                        Position = state and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)
                    }):Play()
                    if config.Callback then config.Callback(state) end
                end
                
                toggleBtn.MouseButton1Click:Connect(function()
                    setState(not state)
                end)
                
                function toggle:SetState(newState)
                    setState(newState)
                end
                
                function toggle:GetState()
                    return state
                end
                
                -- Tooltip
                if config.Tooltip then
                    frame.MouseEnter:Connect(function()
                        window._tooltipText.Text = config.Tooltip
                        window._tooltip.Size = UDim2.new(0, window._tooltipText.TextBounds.X + 12, 0, window._tooltipText.TextBounds.Y + 8)
                        window._tooltip.Visible = true
                    end)
                    frame.MouseLeave:Connect(function()
                        window._tooltip.Visible = false
                    end)
                end
                
                return toggle
            end
            
            function section:CreateSlider(config)
                local slider = {}
                local min = config.Min or 0
                local max = config.Max or 100
                local value = config.Default or 50
                
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1, -12, 0, 50)
                frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                frame.BackgroundTransparency = 0.05
                frame.BorderSizePixel = 0
                frame.Parent = section._frame
                CreateCorner(frame, 6)
                
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -60, 0, 20)
                label.Position = UDim2.new(0, 8, 0, 2)
                label.BackgroundTransparency = 1
                label.Text = config.Name or "Slider"
                label.TextColor3 = Library.Theme.Text
                label.TextSize = 13
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.FontFace = Font.fromName("Gotham")
                label.Parent = frame
                
                local valueLabel = Instance.new("TextLabel")
                valueLabel.Size = UDim2.new(0, 40, 0, 20)
                valueLabel.Position = UDim2.new(1, -48, 0, 2)
                valueLabel.BackgroundTransparency = 1
                valueLabel.Text = tostring(value)
                valueLabel.TextColor3 = Library.Theme.SecondaryText
                valueLabel.TextSize = 13
                valueLabel.TextXAlignment = Enum.TextXAlignment.Right
                valueLabel.FontFace = Font.fromName("GothamBold")
                valueLabel.Parent = frame
                
                local sliderBg = Instance.new("Frame")
                sliderBg.Size = UDim2.new(1, -16, 0, 4)
                sliderBg.Position = UDim2.new(0, 8, 0, 28)
                sliderBg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                sliderBg.BackgroundTransparency = 0.2
                sliderBg.BorderSizePixel = 0
                sliderBg.Parent = frame
                CreateCorner(sliderBg, 2)
                
                local sliderFill = Instance.new("Frame")
                sliderFill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
                sliderFill.BackgroundColor3 = window._accent
                sliderFill.BackgroundTransparency = 0.3
                sliderFill.BorderSizePixel = 0
                sliderFill.Parent = sliderBg
                CreateCorner(sliderFill, 2)
                
                local dragging = false
                
                local function updateSlider(input)
                    local relativeX = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
                    local newValue = min + (max - min) * relativeX
                    newValue = config.Precise and math.floor(newValue) or tonumber(string.format("%.1f", newValue))
                    value = math.clamp(newValue, min, max)
                    
                    sliderFill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
                    valueLabel.Text = tostring(value)
                    if config.Callback then config.Callback(value) end
                end
                
                sliderBg.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        updateSlider(input)
                    end
                end)
                
                sliderBg.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        updateSlider(input)
                    end
                end)
                
                function slider:SetValue(newValue)
                    value = math.clamp(newValue, min, max)
                    sliderFill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
                    valueLabel.Text = tostring(value)
                    if config.Callback then config.Callback(value) end
                end
                
                function slider:GetValue()
                    return value
                end
                
                return slider
            end
            
            function section:CreateDropdown(config)
                local dropdown = {}
                local options = config.Options or {}
                local selected = config.Default or options[1] or ""
                
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1, -12, 0, 32)
                frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                frame.BackgroundTransparency = 0.05
                frame.BorderSizePixel = 0
                frame.Parent = section._frame
                CreateCorner(frame, 6)
                
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(0, 80, 1, 0)
                label.Position = UDim2.new(0, 8, 0, 0)
                label.BackgroundTransparency = 1
                label.Text = config.Name or "Dropdown"
                label.TextColor3 = Library.Theme.Text
                label.TextSize = 13
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.FontFace = Font.fromName("Gotham")
                label.Parent = frame
                
                local dropdownBtn = Instance.new("TextButton")
                dropdownBtn.Size = UDim2.new(1, -100, 0.8, 0)
                dropdownBtn.Position = UDim2.new(0, 90, 0, 3)
                dropdownBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                dropdownBtn.BackgroundTransparency = 0.1
                dropdownBtn.BorderSizePixel = 0
                dropdownBtn.Text = selected
                dropdownBtn.TextColor3 = Library.Theme.Text
                dropdownBtn.TextSize = 13
                dropdownBtn.TextXAlignment = Enum.TextXAlignment.Left
                dropdownBtn.FontFace = Font.fromName("Gotham")
                dropdownBtn.Parent = frame
                CreateCorner(dropdownBtn, 4)
                
                local dropdownList = Instance.new("Frame")
                dropdownList.Size = UDim2.new(1, -100, 0, 0)
                dropdownList.Position = UDim2.new(0, 90, 0, 28)
                dropdownList.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
                dropdownList.BackgroundTransparency = 0.15
                dropdownList.BorderSizePixel = 0
                dropdownList.Visible = false
                dropdownList.ClipsDescendants = true
                dropdownList.Parent = frame
                CreateCorner(dropdownList, 4)
                
                local dropdownListLayout = Instance.new("UIListLayout")
                dropdownListLayout.Padding = UDim.new(0, 2)
                dropdownListLayout.FillDirection = Enum.FillDirection.Vertical
                dropdownListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                dropdownListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
                dropdownListLayout.Parent = dropdownList
                
                local isOpen = false
                
                local function updateDropdown()
                    dropdownBtn.Text = selected
                    if config.Callback then config.Callback(selected) end
                end
                
                for _, option in pairs(options) do
                    local optBtn = Instance.new("TextButton")
                    optBtn.Size = UDim2.new(1, -4, 0, 25)
                    optBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    optBtn.BackgroundTransparency = 0.05
                    optBtn.BorderSizePixel = 0
                    optBtn.Text = option
                    optBtn.TextColor3 = Library.Theme.Text
                    optBtn.TextSize = 12
                    optBtn.FontFace = Font.fromName("Gotham")
                    optBtn.Parent = dropdownList
                    CreateCorner(optBtn, 4)
                    
                    optBtn.MouseButton1Click:Connect(function()
                        selected = option
                        updateDropdown()
                        dropdownList.Visible = false
                        isOpen = false
                        frame.Size = UDim2.new(1, -12, 0, 32)
                    end)
                    
                    optBtn.MouseEnter:Connect(function()
                        optBtn.BackgroundTransparency = 0.15
                    end)
                    optBtn.MouseLeave:Connect(function()
                        optBtn.BackgroundTransparency = 0.05
                    end)
                end
                
                dropdownListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    dropdownList.Size = UDim2.new(1, -100, 0, dropdownListLayout.AbsoluteContentSize.Y + 4)
                end)
                
                dropdownBtn.MouseButton1Click:Connect(function()
                    isOpen = not isOpen
                    dropdownList.Visible = isOpen
                    frame.Size = isOpen and UDim2.new(1, -12, 0, 32 + dropdownListLayout.AbsoluteContentSize.Y + 4) or UDim2.new(1, -12, 0, 32)
                end)
                
                function dropdown:SetOption(option)
                    if table.find(options, option) then
                        selected = option
                        updateDropdown()
                    end
                end
                
                function dropdown:GetOption()
                    return selected
                end
                
                function dropdown:ClearOptions()
                    for _, child in pairs(dropdownList:GetChildren()) do
                        if child:IsA("TextButton") then
                            child:Destroy()
                        end
                    end
                    options = {}
                    selected = ""
                    dropdownBtn.Text = "None"
                end
                
                return dropdown
            end
            
            function section:CreateInput(config)
                local input = {}
                
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1, -12, 0, 32)
                frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                frame.BackgroundTransparency = 0.05
                frame.BorderSizePixel = 0
                frame.Parent = section._frame
                CreateCorner(frame, 6)
                
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(0, 80, 1, 0)
                label.Position = UDim2.new(0, 8, 0, 0)
                label.BackgroundTransparency = 1
                label.Text = config.Name or "Input"
                label.TextColor3 = Library.Theme.Text
                label.TextSize = 13
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.FontFace = Font.fromName("Gotham")
                label.Parent = frame
                
                local textBox = Instance.new("TextBox")
                textBox.Size = UDim2.new(1, -100, 0.8, 0)
                textBox.Position = UDim2.new(0, 90, 0, 3)
                textBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                textBox.BackgroundTransparency = 0.1
                textBox.BorderSizePixel = 0
                textBox.PlaceholderText = config.Placeholder or ""
                textBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
                textBox.Text = ""
                textBox.TextColor3 = Library.Theme.Text
                textBox.TextSize = 13
                textBox.FontFace = Font.fromName("Gotham")
                textBox.Parent = frame
                CreateCorner(textBox, 4)
                
                textBox.FocusLost:Connect(function(enterPressed)
                    if enterPressed then
                        local value = textBox.Text
                        if config.Numeric then
                            value = tonumber(value)
                            if value then
                                if config.Callback then config.Callback(value) end
                            end
                        else
                            if config.Callback then config.Callback(value) end
                        end
                    end
                end)
                
                function input:SetValue(value)
                    textBox.Text = tostring(value)
                    if config.Callback then config.Callback(value) end
                end
                
                return input
            end
            
            function section:CreateColorpicker(config)
                local picker = {}
                local currentColor = config.Default or Color3.fromRGB(255, 255, 255)
                
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1, -12, 0, 32)
                frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                frame.BackgroundTransparency = 0.05
                frame.BorderSizePixel = 0
                frame.Parent = section._frame
                CreateCorner(frame, 6)
                
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -50, 1, 0)
                label.Position = UDim2.new(0, 8, 0, 0)
                label.BackgroundTransparency = 1
                label.Text = config.Name or "Color Picker"
                label.TextColor3 = Library.Theme.Text
                label.TextSize = 13
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.FontFace = Font.fromName("Gotham")
                label.Parent = frame
                
                local colorDisplay = Instance.new("Frame")
                colorDisplay.Size = UDim2.new(0, 24, 0, 24)
                colorDisplay.Position = UDim2.new(1, -32, 0, 4)
                colorDisplay.BackgroundColor3 = currentColor
                colorDisplay.BackgroundTransparency = 0.2
                colorDisplay.BorderSizePixel = 0
                colorDisplay.Parent = frame
                CreateCorner(colorDisplay, 4)
                
                -- Упрощённый цветовой пикер (открывается отдельным окном)
                colorDisplay.MouseButton1Click:Connect(function()
                    -- Здесь можно добавить полноценный цветовой пикер
                    -- Для простоты показываем выбор из предустановленных цветов
                    local colors = {
                        Color3.fromRGB(255, 100, 100),
                        Color3.fromRGB(100, 255, 100),
                        Color3.fromRGB(100, 100, 255),
                        Color3.fromRGB(255, 255, 100),
                        Color3.fromRGB(255, 100, 255),
                        Color3.fromRGB(100, 255, 255),
                        Color3.fromRGB(255, 200, 100),
                        Color3.fromRGB(200, 100, 255)
                    }
                    local idx = math.random(1, #colors)
                    currentColor = colors[idx]
                    colorDisplay.BackgroundColor3 = currentColor
                    if config.Callback then config.Callback(currentColor) end
                end)
                
                function picker:UpdateColor(color)
                    currentColor = color
                    colorDisplay.BackgroundColor3 = color
                    if config.Callback then config.Callback(color) end
                end
                
                return picker
            end
            
            return section
        end
        
        return tab
    end
    
    return window
end

return Library