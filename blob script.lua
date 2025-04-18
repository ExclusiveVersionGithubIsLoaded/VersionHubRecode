--[[
  VERSION HUB ULTIMATE SCRIPT v2
  Improvements:
  - Better intro with circle effects
  - Smooth blur transition
  - Rounded corners
  - Working functions
  - Notification system
  - Better layout
  - Improved close button
  - Customizable glow
  - Draggable menu
  - Balanced particles
  - Smoother animations
]]

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VersionHubPremium"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- =============================================
-- 🎬 IMPROVED INTRO LOADING SCREEN
-- =============================================

local function CreateIntro()
    -- Blur effect for intro
    local blur = Instance.new("BlurEffect")
    blur.Size = 24
    blur.Parent = Lighting

    local introFrame = Instance.new("Frame")
    introFrame.Size = UDim2.new(1, 0, 1, 0)
    introFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    introFrame.BackgroundTransparency = 0.3
    introFrame.BorderSizePixel = 0
    introFrame.ZIndex = 10
    introFrame.Parent = ScreenGui

    -- Circle effect container
    local circleContainer = Instance.new("Frame")
    circleContainer.Size = UDim2.new(1, 0, 1, 0)
    circleContainer.BackgroundTransparency = 1
    circleContainer.ZIndex = 11
    circleContainer.Parent = introFrame

    -- Create circles on both sides
    for side = 1, 2 do
        for i = 1, 15 do
            local circle = Instance.new("Frame")
            circle.Size = UDim2.new(0, math.random(10, 30), 0, math.random(10, 30))
            circle.Position = UDim2.new(
                side == 1 and 0 or 1, 
                side == 1 and math.random(-50, 50) or math.random(-50, 50), 
                0, math.random(0, 600)
            )
            circle.BackgroundColor3 = Color3.fromRGB(
                math.random(50, 150),
                math.random(100, 200),
                math.random(200, 255)
            )
            circle.BackgroundTransparency = 0.7
            circle.BorderSizePixel = 0
            circle.ZIndex = 11
            circle.Parent = circleContainer
            
            -- Make circles round
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(1, 0)
            corner.Parent = circle
            
            -- Smooth movement
            spawn(function()
                local xDirection = side == 1 and 1 or -1
                local speed = math.random(50, 150) / 100
                while circle.Parent do
                    local newX = circle.AbsolutePosition.X + (xDirection * speed)
                    local newY = circle.AbsolutePosition.Y + math.random(-5, 5)
                    
                    -- Wrap around screen
                    if (side == 1 and newX > 1200) or (side == 2 and newX < -200) then
                        newX = side == 1 and -200 or 1200
                        newY = math.random(0, 600)
                    end
                    
                    circle.Position = UDim2.new(
                        0, newX,
                        0, math.clamp(newY, 0, 600)
                    )
                    wait(0.03)
                end
            end)
        end
    end

    -- Main container with rounded corners
    local mainContainer = Instance.new("Frame")
    mainContainer.Size = UDim2.new(0, 400, 0, 300)
    mainContainer.Position = UDim2.new(0.5, -200, 0.5, -150)
    mainContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    mainContainer.BackgroundTransparency = 0.2
    mainContainer.BorderSizePixel = 0
    mainContainer.ZIndex = 12
    mainContainer.Parent = introFrame

    -- Rounded corners
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 8)
    containerCorner.Parent = mainContainer

    -- Improved glow effect
    local glow = Instance.new("UIStroke")
    glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    glow.Color = Color3.fromRGB(0, 150, 255)
    glow.Thickness = 2
    glow.Transparency = 0.5
    glow.Parent = mainContainer

    -- Blue gradient for glow
    local glowGradient = Instance.new("UIGradient")
    glowGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 80, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
    }
    glowGradient.Rotation = 90
    glowGradient.Parent = glow

    -- Logo with version closer
    local logoContainer = Instance.new("Frame")
    logoContainer.Size = UDim2.new(0, 300, 0, 60)
    logoContainer.Position = UDim2.new(0.5, -150, 0.2, -30)
    logoContainer.BackgroundTransparency = 1
    logoContainer.ZIndex = 13
    logoContainer.Parent = mainContainer

    local logo = Instance.new("TextLabel")
    logo.Text = "VERSION HUB"
    logo.Size = UDim2.new(0, 200, 0, 40)
    logo.Position = UDim2.new(0, 0, 0, 0)
    logo.TextColor3 = Color3.fromRGB(255, 255, 255)
    logo.TextScaled = true
    logo.Font = Enum.Font.GothamBold
    logo.BackgroundTransparency = 1
    logo.ZIndex = 13
    logo.TextXAlignment = Enum.TextXAlignment.Left
    logo.Parent = logoContainer

    local version = Instance.new("TextLabel")
    version.Text = "v5.0.2 PREMIUM"
    version.Size = UDim2.new(0, 100, 0, 20)
    version.Position = UDim2.new(0, 200, 0, 20)
    version.TextColor3 = Color3.fromRGB(150, 150, 255)
    version.TextSize = 14
    version.Font = Enum.Font.Gotham
    version.BackgroundTransparency = 1
    version.ZIndex = 13
    version.TextXAlignment = Enum.TextXAlignment.Left
    version.Parent = logoContainer

    -- Text gradient
    local textGradient = Instance.new("UIGradient")
    textGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
    }
    textGradient.Rotation = 90
    textGradient.Parent = logo

    -- Progress bar with rounded corners
    local progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(0, 300, 0, 10)
    progressBar.Position = UDim2.new(0.5, -150, 0.5, -5)
    progressBar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    progressBar.BorderSizePixel = 0
    progressBar.ZIndex = 13
    progressBar.Parent = mainContainer

    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(1, 0)
    progressCorner.Parent = progressBar

    local progressFill = Instance.new("Frame")
    progressFill.Size = UDim2.new(0, 0, 1, 0)
    progressFill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    progressFill.BorderSizePixel = 0
    progressFill.ZIndex = 14
    progressFill.Parent = progressBar

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = progressFill

    -- Progress gradient
    local progressGradient = Instance.new("UIGradient")
    progressGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 80, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
    }
    progressGradient.Parent = progressFill

    -- Loading text
    local loadingText = Instance.new("TextLabel")
    loadingText.Size = UDim2.new(0, 300, 0, 20)
    loadingText.Position = UDim2.new(0.5, -150, 0.6, 0)
    loadingText.Text = "Initializing..."
    loadingText.TextColor3 = Color3.fromRGB(200, 200, 200)
    loadingText.TextSize = 14
    loadingText.Font = Enum.Font.Gotham
    loadingText.BackgroundTransparency = 1
    loadingText.ZIndex = 13
    loadingText.Parent = mainContainer

    -- Loading messages
    local messages = {
        "Loading assets...",
        "Connecting to server...",
        "Initializing UI...",
        "Preparing features...",
        "Almost done...",
        "Ready to rock! 🤘"
    }

    -- Simulate loading
    for i = 1, 100 do
        progressFill.Size = UDim2.new(i/100, 0, 1, 0)
        if i % 20 == 0 then
            loadingText.Text = messages[math.floor(i/20) + 1]
        end
        wait(0.05)
    end

    wait(1)
    
    -- Smooth blur fade out
    for i = 1, 0, -0.05 do
        blur.Size = 24 * i
        wait(0.03)
    end
    blur:Destroy()
    
    introFrame:Destroy()
end

-- =============================================
-- 💎 IMPROVED MAIN MENU
-- =============================================

local function CreateMainMenu()
    -- Main frame with rounded corners
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 600)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = ScreenGui

    -- Rounded corners
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 8)
    mainCorner.Parent = mainFrame

    -- Blue glow
    local glow = Instance.new("UIStroke")
    glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    glow.Color = Color3.fromRGB(0, 150, 255)
    glow.Thickness = 2
    glow.Transparency = 0.3
    glow.Parent = mainFrame

    -- Blue gradient for glow
    local glowGradient = Instance.new("UIGradient")
    glowGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 80, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
    }
    glowGradient.Rotation = 90
    glowGradient.Parent = glow

    -- Make frame draggable
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    mainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    -- Top bar with rounded top corners
    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 50)
    topBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    topBar.BackgroundTransparency = 0.7
    topBar.BorderSizePixel = 0
    topBar.Parent = mainFrame

    local topBarCorner = Instance.new("UICorner")
    topBarCorner.CornerRadius = UDim.new(0, 8)
    topBarCorner.Parent = topBar

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 200, 1, 0)
    title.Text = "VERSION HUB"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 24
    title.Font = Enum.Font.GothamBold
    title.BackgroundTransparency = 1
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Position = UDim2.new(0, 15, 0, 0)
    title.Parent = topBar

    local version = Instance.new("TextLabel")
    version.Size = UDim2.new(0, 120, 1, 0)
    version.Text = "v5.0.2 PREMIUM"
    version.TextColor3 = Color3.fromRGB(150, 150, 255)
    version.TextSize = 16
    version.Font = Enum.Font.Gotham
    version.BackgroundTransparency = 1
    version.TextXAlignment = Enum.TextXAlignment.Left
    version.Position = UDim2.new(0, 180, 0, 0)
    version.Parent = topBar

    -- Improved close button
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 40, 0, 40)
    closeButton.Position = UDim2.new(1, -50, 0.5, -20)
    closeButton.Text = "×"
    closeButton.TextColor3 = Color3.fromRGB(255, 150, 150)
    closeButton.TextSize = 30
    closeButton.Font = Enum.Font.GothamBold
    closeButton.BackgroundColor3 = Color3.fromRGB(40, 10, 10)
    closeButton.BackgroundTransparency = 0.7
    closeButton.Parent = topBar

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(1, 0)
    closeCorner.Parent = closeButton

    local closeGlow = Instance.new("UIStroke")
    closeGlow.Color = Color3.fromRGB(255, 100, 100)
    closeGlow.Thickness = 1
    closeGlow.Transparency = 0.7
    closeGlow.Parent = closeButton

    local menuVisible = true

    local function ToggleMenu()
        menuVisible = not menuVisible
        if menuVisible then
            mainFrame.Visible = true
            TweenService:Create(
                mainFrame,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                {Size = UDim2.new(0, 500, 0, 600)}
            ):Play()
        else
            TweenService:Create(
                mainFrame,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                {Size = UDim2.new(0, 500, 0, 0)}
            ):Play()
            wait(0.3)
            mainFrame.Visible = false
        end
    end

    closeButton.MouseButton1Click:Connect(function()
        ToggleMenu()
        
        -- Show notification
        local notify = Instance.new("TextLabel")
        notify.Text = "Press RIGHT SHIFT to open/close menu"
        notify.Size = UDim2.new(0, 300, 0, 40)
        notify.Position = UDim2.new(0.5, -150, 1, -100)
        notify.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        notify.BackgroundTransparency = 0.5
        notify.TextColor3 = Color3.fromRGB(255, 255, 255)
        notify.TextSize = 14
        notify.Font = Enum.Font.Gotham
        notify.Parent = ScreenGui
        
        local notifyCorner = Instance.new("UICorner")
        notifyCorner.CornerRadius = UDim.new(0, 8)
        notifyCorner.Parent = notify
        
        wait(3)
        TweenService:Create(
            notify,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad),
            {BackgroundTransparency = 1, TextTransparency = 1}
        ):Play()
        wait(0.5)
        notify:Destroy()
    end)

    -- Close button hover effects
    closeButton.MouseEnter:Connect(function()
        TweenService:Create(
            closeButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
            {BackgroundTransparency = 0.5, TextColor3 = Color3.fromRGB(255, 100, 100)}
        ):Play()
    end)

    closeButton.MouseLeave:Connect(function()
        TweenService:Create(
            closeButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
            {BackgroundTransparency = 0.7, TextColor3 = Color3.fromRGB(255, 150, 150)}
        ):Play()
    end)

    -- Keybind to toggle menu
    UserInputService.InputBegan:Connect(function(input, processed)
        if not processed and input.KeyCode == Enum.KeyCode.RightShift then
            ToggleMenu()
        end
    end)

    -- Tabs with rounded corners
    local tabs = {"Main", "Combat", "Visuals", "Misc", "Settings"}
    local tabButtons = {}

    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, -30, 0, 40)
    tabContainer.Position = UDim2.new(0, 15, 0, 60)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Parent = mainFrame

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.FillDirection = Enum.FillDirection.Horizontal
    uiListLayout.Padding = UDim.new(0, 5)
    uiListLayout.Parent = tabContainer

    -- Create tabs
    for i, tabName in ipairs(tabs) do
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(0, 80, 1, 0)
        tabButton.Text = tabName
        tabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        tabButton.TextSize = 16
        tabButton.Font = Enum.Font.Gotham
        tabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        tabButton.BackgroundTransparency = 0.5
        
        -- Rounded corners for tab
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 6)
        tabCorner.Parent = tabButton
        
        -- Tab indicator
        local indicator = Instance.new("Frame")
        indicator.Size = UDim2.new(1, 0, 0, 3)
        indicator.Position = UDim2.new(0, 0, 1, -3)
        indicator.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
        indicator.Visible = i == 1
        indicator.Parent = tabButton
        
        -- Rounded corners for indicator
        local indicatorCorner = Instance.new("UICorner")
        indicatorCorner.CornerRadius = UDim.new(0, 2)
        indicatorCorner.Parent = indicator
        
        tabButton.MouseButton1Click:Connect(function()
            -- Hide all indicators
            for _, btn in ipairs(tabButtons) do
                btn.indicator.Visible = false
                TweenService:Create(
                    btn,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                    {BackgroundTransparency = 0.5, TextColor3 = Color3.fromRGB(200, 200, 200)}
                ):Play()
            end
            
            -- Show current indicator
            indicator.Visible = true
            TweenService:Create(
                tabButton,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                {BackgroundTransparency = 0.3, TextColor3 = Color3.fromRGB(255, 255, 255)}
            ):Play()
        end)
        
        tabButton.indicator = indicator
        table.insert(tabButtons, tabButton)
        tabButton.Parent = tabContainer
    end

    -- Content frame
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -30, 1, -120)
    contentFrame.Position = UDim2.new(0, 15, 0, 110)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    -- Main tab content
    local mainContent = Instance.new("Frame")
    mainContent.Size = UDim2.new(1, 0, 1, 0)
    mainContent.BackgroundTransparency = 1
    mainContent.Visible = true
    mainContent.Parent = contentFrame

    -- Section title
    local sectionTitle = Instance.new("TextLabel")
    sectionTitle.Size = UDim2.new(1, 0, 0, 30)
    sectionTitle.Text = "MAIN FEATURES"
    sectionTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
    sectionTitle.TextSize = 18
    sectionTitle.Font = Enum.Font.GothamBold
    sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    sectionTitle.BackgroundTransparency = 1
    sectionTitle.Parent = mainContent

    -- Toggle switch with rounded corners
    local toggleContainer = Instance.new("Frame")
    toggleContainer.Size = UDim2.new(1, 0, 0, 30)
    toggleContainer.Position = UDim2.new(0, 0, 0, 40)
    toggleContainer.BackgroundTransparency = 1
    toggleContainer.Parent = mainContent

    local toggleText = Instance.new("TextLabel")
    toggleText.Size = UDim2.new(0, 200, 1, 0)
    toggleText.Text = "God Mode"
    toggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleText.TextSize = 16
    toggleText.Font = Enum.Font.Gotham
    toggleText.TextXAlignment = Enum.TextXAlignment.Left
    toggleText.BackgroundTransparency = 1
    toggleText.Parent = toggleContainer

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 50, 0, 25)
    toggleButton.Position = UDim2.new(1, -50, 0.5, -12)
    toggleButton.Text = ""
    toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    
    -- Rounded toggle
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggleButton

    local toggleIndicator = Instance.new("Frame")
    toggleIndicator.Size = UDim2.new(0, 23, 1, -4)
    toggleIndicator.Position = UDim2.new(0, 2, 0, 2)
    toggleIndicator.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    toggleIndicator.BorderSizePixel = 0
    
    -- Rounded indicator
    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(1, 0)
    indicatorCorner.Parent = toggleIndicator

    local toggleState = false

    toggleButton.MouseButton1Click:Connect(function()
        toggleState = not toggleState
        if toggleState then
            TweenService:Create(
                toggleIndicator,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Position = UDim2.new(1, -25, 0, 2), BackgroundColor3 = Color3.fromRGB(0, 255, 100)}
            ):Play()
            -- Add your function here
            print("God Mode enabled!")
        else
            TweenService:Create(
                toggleIndicator,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Position = UDim2.new(0, 2, 0, 2), BackgroundColor3 = Color3.fromRGB(255, 100, 100)}
            ):Play()
            -- Add your function here
            print("God Mode disabled!")
        end
    end)

    -- Gradient button with rounded corners
    local gradientButton = Instance.new("TextButton")
    gradientButton.Size = UDim2.new(0, 200, 0, 40)
    gradientButton.Position = UDim2.new(0.5, -100, 0, 100)
    gradientButton.Text = "ACTIVATE ALL"
    gradientButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    gradientButton.TextSize = 16
    gradientButton.Font = Enum.Font.GothamBold
    
    -- Rounded button
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = gradientButton

    local buttonGradient = Instance.new("UIGradient")
    buttonGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 150))
    }
    buttonGradient.Rotation = 90
    buttonGradient.Parent = gradientButton

    -- Button click function
    gradientButton.MouseButton1Click:Connect(function()
        -- Add your function here
        print("All features activated!")
        
        -- Pulse effect on click
        TweenService:Create(
            gradientButton,
            TweenInfo.new(0.1, Enum.EasingStyle.Quad),
            {Size = UDim2.new(0, 190, 0, 38)}
        ):Play()
        wait(0.1)
        TweenService:Create(
            gradientButton,
            TweenInfo.new(0.1, Enum.EasingStyle.Quad),
            {Size = UDim2.new(0, 200, 0, 40)}
        ):Play()
    end)

    -- Button hover effects
    gradientButton.MouseEnter:Connect(function()
        TweenService:Create(
            buttonGradient,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Rotation = 270}
        ):Play()
    end)

    gradientButton.MouseLeave:Connect(function()
        TweenService:Create(
            buttonGradient,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Rotation = 90}
        ):Play()
    end)

    -- Slider control with rounded corners
    local sliderContainer = Instance.new("Frame")
    sliderContainer.Size = UDim2.new(1, 0, 0, 50)
    sliderContainer.Position = UDim2.new(0, 0, 0, 160)
    sliderContainer.BackgroundTransparency = 1
    sliderContainer.Parent = mainContent

    local sliderText = Instance.new("TextLabel")
    sliderText.Size = UDim2.new(0, 200, 0, 20)
    sliderText.Text = "Walk Speed: 16"
    sliderText.TextColor3 = Color3.fromRGB(255, 255, 255)
    sliderText.TextSize = 14
    sliderText.Font = Enum.Font.Gotham
    sliderText.TextXAlignment = Enum.TextXAlignment.Left
    sliderText.BackgroundTransparency = 1
    sliderText.Parent = sliderContainer

    local sliderTrack = Instance.new("Frame")
    sliderTrack.Size = UDim2.new(1, 0, 0, 5)
    sliderTrack.Position = UDim2.new(0, 0, 0, 25)
    sliderTrack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sliderTrack.BorderSizePixel = 0
    
    -- Rounded slider track
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(1, 0)
    trackCorner.Parent = sliderTrack

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(0.5, 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderTrack
    
    -- Rounded slider fill
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = sliderFill

    local sliderButton = Instance.new("TextButton")
    sliderButton.Size = UDim2.new(0, 15, 0, 15)
    sliderButton.Position = UDim2.new(0.5, -7, 0, -5)
    sliderButton.Text = ""
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderButton.BorderSizePixel = 0
    
    -- Rounded slider button
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(1, 0)
    buttonCorner.Parent = sliderButton

    -- Slider function
    local function updateWalkSpeed(value)
        -- Add your function here
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = value
        end
    end

    -- Slider drag logic
    local dragging = false
    local function updateSlider(input)
        local pos = UDim2.new(
            math.clamp((input.Position.X - sliderTrack.AbsolutePosition.X) / sliderTrack.AbsoluteSize.X, 0, 1),
            0, 0, 0)
        sliderFill.Size = UDim2.new(pos.X.Scale, 0, 1, 0)
        sliderButton.Position = UDim2.new(pos.X.Scale, -7, 0, -5)
        local value = math.floor(pos.X.Scale * 50) + 16 -- Range 16-66
        sliderText.Text = "Walk Speed: " .. tostring(value)
        updateWalkSpeed(value)
    end

    sliderButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    sliderButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)

    -- Add all elements
    toggleIndicator.Parent = toggleButton
    toggleButton.Parent = toggleContainer
    toggleText.Parent = toggleContainer
    sliderText.Parent = sliderContainer
    sliderButton.Parent = sliderContainer
    sliderTrack.Parent = sliderContainer
    gradientButton.Parent = mainContent
end


CreateIntro()


wait(0.5)
CreateMainMenu()
