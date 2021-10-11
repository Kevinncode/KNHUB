-- Feel free to edit, modify or use!

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Mouse = game:GetService("Players").LocalPlayer:GetMouse()

local RainbowModeColorValue = 0
local ColorPickerZIndex = 1

local RainbowModeColorValue = 0
local ColorPickerZIndex = 1

local WindowPosition = 0

local CoastifiedLibrary = Instance.new("ScreenGui")
local Container = Instance.new("Frame")

CoastifiedLibrary.Name = "CoastifiedLibrary"
CoastifiedLibrary.Parent = game:GetService("CoreGui")

Container.Name = "Container"
Container.Parent = CoastifiedLibrary
Container.BackgroundColor3 = Color3.new(1, 1, 1)
Container.BackgroundTransparency = 1
Container.Size = UDim2.new(0, 100, 0, 100)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        CoastifiedLibrary.Enabled = not CoastifiedLibrary.Enabled
    end
end)

function Dragging(instancename)
    local dragging = nil
    local dragInput = nil
    local dragStart = nil
    local startPos = nil

    local function update(input)
        local delta = input.Position - dragStart
        instancename.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    instancename.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = instancename.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    instancename.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

local function RemoveSpaces(str)
    return str:gsub(" ", "")
end

coroutine.wrap(function()
    while wait() do
        RainbowModeColorValue = RainbowModeColorValue + 1/255
        if RainbowModeColorValue >= 1 then
            RainbowModeColorValue = 0
        end
    end
end)()


local Library = {}

function Library:NewWindow(name)
    local Window = Instance.new("ImageLabel")
    local Topbar = Instance.new("Frame")
    local WindowToggle = Instance.new("TextButton")
    local WindowTitle = Instance.new("TextLabel")
    local BottomRoundCover = Instance.new("Frame")
    local Body = Instance.new("ImageLabel")
    local Sorter = Instance.new("UIListLayout")
    local TopbarBodyCover = Instance.new("Frame")

    local WindowName = RemoveSpaces(name)

    WindowPosition = WindowPosition + 2

    local BodyYSize = 35
    local IsTabOpen = true

    local function ExtendBodySize(value)
        BodyYSize = BodyYSize + value

        TweenService:Create(Body, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 170, 0, BodyYSize)}):Play()
    end

    local function UnExtendBodySize(value)
        BodyYSize = BodyYSize - value

        TweenService:Create(Body, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 170, 0, BodyYSize)}):Play()
    end

    
    Window.Name = (WindowName .. "Window")
    Window.Parent = Container
    Window.BackgroundColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
    Window.BackgroundTransparency = 1
    Window.Position = UDim2.new(WindowPosition, -100, 3, -265)
    Window.Size = UDim2.new(0, 170, 0, 30)
    Window.ZIndex = 2
    Window.Image = "rbxassetid://3570695787"
    Window.ImageColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
    Window.ScaleType = Enum.ScaleType.Slice
    Window.SliceCenter = Rect.new(100, 100, 100, 100)
    Window.SliceScale =  0.05

    Topbar.Name = "Topbar"
    Topbar.Parent = Window
    Topbar.BackgroundColor3 = Color3.new(1, 1, 1)
    Topbar.BackgroundTransparency = 1
    Topbar.BorderSizePixel = 0
    Topbar.Size = UDim2.new(0, 170, 0, 30)
    Topbar.ZIndex = 2

    WindowToggle.Name = "WindowToggle"
    WindowToggle.Parent = Topbar
    WindowToggle.BackgroundColor3 = Color3.new(1, 1, 1)
    WindowToggle.BackgroundTransparency = 1
    WindowToggle.Position = UDim2.new(0.822450161, 0, 0, 0)
    WindowToggle.Size = UDim2.new(0, 30, 0, 30)
    WindowToggle.ZIndex = 2
    WindowToggle.Font = Enum.Font.SourceSansSemibold
    WindowToggle.Text = "-"
    WindowToggle.TextColor3 = Color3.new(1, 1, 1)
    WindowToggle.TextSize = 20
    WindowToggle.TextWrapped = true

    WindowToggle.MouseButton1Down:Connect(function()
        if not IsTabOpen then
            IsTabOpen = true
            TweenService:Create(WindowToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()

            WindowToggle.Text = "-"
            WindowToggle.TextSize = 20
            WindowToggle.Visible = false
 
            repeat wait() until WindowToggle.TextTransparency == 1
            WindowToggle.Visible = true
            TweenService:Create(WindowToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
        elseif IsTabOpen then
            IsTabOpen = false
            TweenService:Create(WindowToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
           
            WindowToggle.Text = "v"
            WindowToggle.TextSize = 14
            WindowToggle.Visible = false       

            repeat wait() until WindowToggle.TextTransparency == 1
            WindowToggle.Visible = true
            TweenService:Create(WindowToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
        end
    end)

    WindowTitle.Name = "WindowTitle"
    WindowTitle.Parent = Topbar
    WindowTitle.BackgroundColor3 = Color3.new(1, 1, 1)
    WindowTitle.BackgroundTransparency = 1
    WindowTitle.Size = UDim2.new(0, 170, 0, 30)
    WindowTitle.ZIndex = 2
    WindowTitle.Font = Enum.Font.SourceSansBold
    WindowTitle.Text = name
    WindowTitle.TextColor3 = Color3.new(1, 1, 1)
    WindowTitle.TextSize = 17

    BottomRoundCover.Name = "BottomRoundCover"
    BottomRoundCover.Parent = Topbar
    BottomRoundCover.BackgroundColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
    BottomRoundCover.BorderSizePixel = 0
    BottomRoundCover.Position = UDim2.new(0, 0, 0.833333313, 0)
    BottomRoundCover.Size = UDim2.new(0, 170, 0, 5)
    BottomRoundCover.ZIndex = 2

    Body.Name = "Body"
    Body.Parent = Window
    Body.BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255)
    Body.BackgroundTransparency = 1
    Body.ClipsDescendants = true
    Body.Size = UDim2.new(0, 170, 0, BodyYSize)
    Body.Image = "rbxassetid://3570695787"
    Body.ImageColor3 = Color3.new(0.137255, 0.137255, 0.137255)
    Body.ScaleType = Enum.ScaleType.Slice
    Body.SliceCenter = Rect.new(100, 100, 100, 100)
    Body.SliceScale =  0.05

    Sorter.Name = "Sorter"
    Sorter.Parent = Body
    Sorter.SortOrder = Enum.SortOrder.LayoutOrder

    TopbarBodyCover.Name = "TopbarBodyCover"
    TopbarBodyCover.Parent = Body
    TopbarBodyCover.BackgroundColor3 = Color3.new(1, 1, 1)
    TopbarBodyCover.BackgroundTransparency = 1
    TopbarBodyCover.BorderSizePixel = 0
    TopbarBodyCover.Size = UDim2.new(0, 170, 0, 30)

    Dragging(Window)

    local Sections = {}

    function Sections:NewSection(name)
        local Section1Holder = Instance.new("Frame")
        local SectionInfo = Instance.new("Frame")
        local SectionToggle = Instance.new("TextButton")
        local SectionTitle = Instance.new("TextLabel")
        local Layout = Instance.new("UIListLayout")

        local SectionName = RemoveSpaces(name)
        local SectionToggleText = "v"
        local SectionYSize = 30
        local IsSectionOpen = false

        local function ExtendSectionSize(value)
            SectionYSize = SectionYSize + value
    
            TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 170, 0, SectionYSize)}):Play()
        end
    
        local function UnExtendSectionSize(value)
            SectionYSize = SectionYSize - value
    
            TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 170, 0, SectionYSize)}):Play()
        end

        Section1Holder.Name = (SectionName .. "Section")
        Section1Holder.Parent = Body
        Section1Holder.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
        Section1Holder.BorderSizePixel = 0
        Section1Holder.ClipsDescendants = true
        Section1Holder.Size = UDim2.new(0, 170, 0, SectionYSize)
        
        ExtendBodySize(30)

        SectionInfo.Name = "SectionInfo"
        SectionInfo.Parent = Section1Holder
        SectionInfo.BackgroundColor3 = Color3.new(1, 1, 1)
        SectionInfo.BackgroundTransparency = 1
        SectionInfo.Size = UDim2.new(0, 170, 0, 30)
        
        SectionToggle.Name = "SectionToggle"
        SectionToggle.Parent = SectionInfo
        SectionToggle.BackgroundColor3 = Color3.new(1, 1, 1)
        SectionToggle.BackgroundTransparency = 1
        SectionToggle.Position = UDim2.new(0.822450161, 0, 0, 0)
        SectionToggle.Size = UDim2.new(0, 30, 0, 30)
        SectionToggle.ZIndex = 2
        SectionToggle.Font = Enum.Font.SourceSansSemibold
        SectionToggle.Text = SectionToggleText
        SectionToggle.TextColor3 = Color3.new(1, 1, 1)
        SectionToggle.TextSize = 14
        SectionToggle.TextWrapped = true
        
        SectionTitle.Name = "SectionTitle"
        SectionTitle.Parent = SectionInfo
        SectionTitle.BackgroundColor3 = Color3.new(1, 1, 1)
        SectionTitle.BackgroundTransparency = 1
        SectionTitle.BorderSizePixel = 0
        SectionTitle.Position = UDim2.new(0.052941177, 0, 0, 0)
        SectionTitle.Size = UDim2.new(0, 125, 0, 30)
        SectionTitle.Font = Enum.Font.SourceSansBold
        SectionTitle.Text = name
        SectionTitle.TextColor3 = Color3.new(1, 1, 1)
        SectionTitle.TextSize = 17
        SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
        
        Layout.Name = "Layout"
        Layout.Parent = Section1Holder
        Layout.SortOrder = Enum.SortOrder.LayoutOrder

        WindowToggle.MouseButton1Down:Connect(function()
            if not IsTabOpen then
                ExtendBodySize(30)
                SectionToggle.Text = SectionToggleText
                TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
            elseif IsTabOpen then
                UnExtendBodySize(30)
                SectionToggle.Text = ""
                TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
            end
        end)

        SectionToggle.MouseButton1Down:Connect(function()
            if not IsSectionOpen then
                IsSectionOpen = true
                SectionToggleText = "-"

                TweenService:Create(SectionToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
                TweenService:Create(WindowToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()

                SectionToggle.Text = SectionToggleText
                SectionToggle.TextSize = 20
                SectionToggle.Visible = false
                WindowToggle.Visible = false

                repeat wait() until SectionToggle.TextTransparency == 1 and WindowToggle.TextTransparency == 1
                SectionToggle.Visible = true
                WindowToggle.Visible = true
                TweenService:Create(SectionToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
                TweenService:Create(WindowToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
            elseif IsSectionOpen then
                IsSectionOpen = false
                SectionToggleText = "v"

                TweenService:Create(SectionToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
                TweenService:Create(WindowToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()

                SectionToggle.Text = SectionToggleText
                SectionToggle.TextSize = 14
                SectionToggle.Visible = false
                WindowToggle.Visible = false

                repeat wait() until SectionToggle.TextTransparency == 1 and WindowToggle.TextTransparency == 1
                SectionToggle.Visible = true
                WindowToggle.Visible = true
                TweenService:Create(SectionToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
                TweenService:Create(WindowToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
            end
        end)

        local LibraryElements = {}

        function LibraryElements:CreateToggle(name, action)
            local ToggleHolder = Instance.new("Frame")
            local ToggleTitle = Instance.new("TextLabel")
            local ToggleBackground = Instance.new("ImageLabel")
            local ToggleButton = Instance.new("ImageButton")
        
            local ToggleName = RemoveSpaces(name)
            local Toggled = false

            ToggleHolder.Name = (ToggleName .. "ToggleHolder")
            ToggleHolder.Parent = Section1Holder
            ToggleHolder.BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255)
            ToggleHolder.BorderSizePixel = 0
            ToggleHolder.Size = UDim2.new(0, 170, 0, 30)
        
            ToggleTitle.Name = "ToggleTitle"
            ToggleTitle.Parent = ToggleHolder
            ToggleTitle.BackgroundColor3 = Color3.new(1, 1, 1)
            ToggleTitle.BackgroundTransparency = 1
            ToggleTitle.BorderSizePixel = 0
            ToggleTitle.Position = UDim2.new(0.052941177, 0, 0, 0)
            ToggleTitle.Size = UDim2.new(0, 125, 0, 30)
            ToggleTitle.Font = Enum.Font.SourceSansBold
            ToggleTitle.Text = name
            ToggleTitle.TextColor3 = Color3.new(1, 1, 1)
            ToggleTitle.TextSize = 17
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
        
            ToggleBackground.Name = "ToggleBackground"
            ToggleBackground.Parent = ToggleHolder
            ToggleBackground.BackgroundColor3 = Color3.new(1, 1, 1)
            ToggleBackground.BackgroundTransparency = 1
            ToggleBackground.BorderSizePixel = 0
            ToggleBackground.Position = UDim2.new(0.847058833, 0, 0.166666672, 0)
            ToggleBackground.Size = UDim2.new(0, 20, 0, 20)
            ToggleBackground.Image = "rbxassetid://3570695787"
            ToggleBackground.ImageColor3 = Color3.new(0.254902, 0.254902, 0.254902)
        
            ToggleButton.Name = "ToggleButton"
            ToggleButton.Parent = ToggleBackground
            ToggleButton.BackgroundColor3 = Color3.new(1, 1, 1)
            ToggleButton.BackgroundTransparency = 1
            ToggleButton.Position = UDim2.new(0, 2, 0, 2)
            ToggleButton.Size = UDim2.new(0, 16, 0, 16)
            ToggleButton.Image = "rbxassetid://3570695787"
            ToggleButton.ImageColor3 = Color3.new(1, 0.341176, 0.341176)
            ToggleButton.ImageTransparency = 1

            ToggleButton.MouseButton1Down:Connect(function()	
                Toggled = not Toggled
            
                if Toggled then
                    TweenService:Create(ToggleButton, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
                elseif not Toggled then
                    TweenService:Create(ToggleButton, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
                end

                action(Toggled)
            end)

            SectionToggle.MouseButton1Down:Connect(function()
                if not IsSectionOpen then
                    ExtendSectionSize(30)
                    ExtendBodySize(30)
                elseif IsSectionOpen then
                    UnExtendSectionSize(30)
                    UnExtendBodySize(30)
                end
            end)

            WindowToggle.MouseButton1Down:Connect(function()
                if not IsTabOpen then
                    if IsSectionOpen then
                        ExtendBodySize(30)
                        TweenService:Create(SectionToggle, TweenInfo.new(0, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 360}):Play()
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                    elseif not IsSectionOpen then
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                    end

                    
                elseif IsTabOpen then
                    if IsSectionOpen then
                        UnExtendBodySize(30)
                        TweenService:Create(SectionToggle, TweenInfo.new(0, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    elseif not IsSectionOpen then
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    end
                end

                TweenService:Create(SectionToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
        
                SectionToggle.Visible = false
        
                repeat wait() until SectionToggle.TextTransparency == 1
                SectionToggle.Visible = true
                TweenService:Create(SectionToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
            end)
        end

        function LibraryElements:CreateSlider(name, minimumvalue, maximumvalue, startvalue, precisevalue, action)
            local SliderHolder = Instance.new("Frame")
            local SliderTitle = Instance.new("TextLabel")
            local SliderValueHolder = Instance.new("ImageLabel")
            local SliderValue = Instance.new("TextLabel")
            local SliderBackground = Instance.new("ImageLabel")
            local Slider = Instance.new("ImageLabel")

            local SliderName = RemoveSpaces(name)
            local Dragging = false
            local PreciseSliderValue = precisevalue

            SliderHolder.Name = (SliderName .. "SliderHolder")
            SliderHolder.Parent = Section1Holder
            SliderHolder.BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255)
            SliderHolder.BorderSizePixel = 0
            SliderHolder.Size = UDim2.new(0, 170, 0, 30)

            SliderTitle.Name = "SliderTitle"
            SliderTitle.Parent = SliderHolder
            SliderTitle.BackgroundColor3 = Color3.new(1, 1, 1)
            SliderTitle.BackgroundTransparency = 1
            SliderTitle.BorderSizePixel = 0
            SliderTitle.Position = UDim2.new(0.052941177, 0, 0, 0)
            SliderTitle.Size = UDim2.new(0, 125, 0, 15)
            SliderTitle.Font = Enum.Font.SourceSansSemibold
            SliderTitle.Text = name
            SliderTitle.TextColor3 = Color3.new(1, 1, 1)
            SliderTitle.TextSize = 17
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

            SliderValueHolder.Name = "SliderValueHolder"
            SliderValueHolder.Parent = SliderHolder
            SliderValueHolder.BackgroundColor3 = Color3.new(0.254902, 0.254902, 0.254902)
            SliderValueHolder.BackgroundTransparency = 1
            SliderValueHolder.Position = UDim2.new(0.747058809, 0, 0, 0)
            SliderValueHolder.Size = UDim2.new(0, 35, 0, 15)
            SliderValueHolder.Image = "rbxassetid://3570695787"
            SliderValueHolder.ImageColor3 = Color3.new(0.254902, 0.254902, 0.254902)
            SliderValueHolder.ImageTransparency = 0.5
            SliderValueHolder.ScaleType = Enum.ScaleType.Slice
            SliderValueHolder.SliceCenter = Rect.new(100, 100, 100, 100)
            SliderValueHolder.SliceScale = 0.02

            SliderValue.Name = "SliderValue"
            SliderValue.Parent = SliderValueHolder
            SliderValue.BackgroundColor3 = Color3.new(1, 1, 1)
            SliderValue.BackgroundTransparency = 1
            SliderValue.Size = UDim2.new(0, 35, 0, 15)
            SliderValue.Font = Enum.Font.SourceSansSemibold
            SliderValue.Text = tostring(startvalue or PreciseSliderValue and tonumber(string.format("%.2f", startvalue)))
            SliderValue.TextColor3 = Color3.new(1, 1, 1)
            SliderValue.TextSize = 14

            SliderBackground.Name = "SliderBackground"
            SliderBackground.Parent = SliderHolder
            SliderBackground.BackgroundColor3 = Color3.new(0.254902, 0.254902, 0.254902)
            SliderBackground.BackgroundTransparency = 1
            SliderBackground.Position = UDim2.new(0.0529999994, 0, 0.649999976, 0)
            SliderBackground.Selectable = true
            SliderBackground.Size = UDim2.new(0, 153, 0, 5)
            SliderBackground.Image = "rbxassetid://3570695787"
            SliderBackground.ImageColor3 = Color3.new(0.254902, 0.254902, 0.254902)
            SliderBackground.ImageTransparency = 0.5
            SliderBackground.ScaleType = Enum.ScaleType.Slice
            SliderBackground.SliceCenter = Rect.new(100, 100, 100, 100)
            SliderBackground.ClipsDescendants = true
            SliderBackground.SliceScale = 0.02

            Slider.Name = "Slider"
            Slider.Parent = SliderBackground
            Slider.BackgroundColor3 = Color3.new(1, 1, 1)
            Slider.BackgroundTransparency = 1
            Slider.Size = UDim2.new(((startvalue or minimumvalue) - minimumvalue) / (maximumvalue - minimumvalue), 0, 0, 5)
            Slider.Image = "rbxassetid://3570695787"
            Slider.ScaleType = Enum.ScaleType.Slice
            Slider.SliceCenter = Rect.new(100, 100, 100, 100)
            Slider.SliceScale = 0.02

            local function Sliding(input)
                local Pos = UDim2.new(math.clamp((input.Position.X - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X, 0, 1), 0, 1.15, 0)
                TweenService:Create(Slider, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = Pos}):Play()

                local NonSliderPreciseValue = math.floor(((Pos.X.Scale * maximumvalue) / maximumvalue) * (maximumvalue - minimumvalue) + minimumvalue)
                local SliderPreciseValue = ((Pos.X.Scale * maximumvalue) / maximumvalue) * (maximumvalue - minimumvalue) + minimumvalue
    
                local Value = (PreciseSliderValue and SliderPreciseValue or NonSliderPreciseValue)
                Value = tonumber(string.format("%.2f", Value))
    
                SliderValue.Text = tostring(Value)
                action(Value)
            end
        
            SliderBackground.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Dragging = true
                end
            end)
            
            SliderBackground.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Dragging = false
                end
            end)
            
            SliderBackground.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Sliding(input)
                end
            end)
        
            UserInputService.InputChanged:Connect(function(input)
                if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    Sliding(input)
                end
            end)

            SectionToggle.MouseButton1Down:Connect(function()
                if not IsSectionOpen then
                    ExtendSectionSize(30)
                    ExtendBodySize(30)
                elseif IsSectionOpen then
                    UnExtendSectionSize(30)
                    UnExtendBodySize(30)
                end
            end)

            WindowToggle.MouseButton1Down:Connect(function()
                if not IsTabOpen then
                    if IsSectionOpen then
                        ExtendBodySize(30)
                        TweenService:Create(SectionToggle, TweenInfo.new(0, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 360}):Play()
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                    elseif not IsSectionOpen then
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                    end

                    
                elseif IsTabOpen then
                    if IsSectionOpen then
                        UnExtendBodySize(30)
                        TweenService:Create(SectionToggle, TweenInfo.new(0, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    elseif not IsSectionOpen then
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    end
                end

                TweenService:Create(SectionToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
        
                SectionToggle.Visible = false
        
                repeat wait() until SectionToggle.TextTransparency == 1
                SectionToggle.Visible = true
                TweenService:Create(SectionToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
            end)
        end

        function LibraryElements:CreateColorPicker(name, presetcolor, action)
            local ColorPickerHolder = Instance.new("Frame")
            local RainbowToggleHolder = Instance.new("Frame")
            local RainbowTitle = Instance.new("TextLabel")
            local RainbowBackground = Instance.new("ImageLabel")
            local RainbowToggleButton = Instance.new("ImageButton")
            local ColorPickerTitle = Instance.new("TextLabel")
            local ColorPickerToggle = Instance.new("ImageButton")
            local ColorPickerMain = Instance.new("ImageLabel")
            local ColorValueR = Instance.new("TextLabel")
            local ColorValueRRound = Instance.new("ImageLabel")
            local ColorValueB = Instance.new("TextLabel")
            local ColorValueBRound = Instance.new("ImageLabel")
            local ColorValueG = Instance.new("TextLabel")
            local ColorValueGRound = Instance.new("ImageLabel")
            local RoundHueHolder = Instance.new("ImageLabel")
            local ColorHue = Instance.new("ImageLabel")
            local HueMarker = Instance.new("Frame")
            local RoundSaturationHolder = Instance.new("ImageLabel")
            local ColorSelector = Instance.new("ImageLabel")
            local SaturationMarker = Instance.new("ImageLabel")

            local ColorPickerName = RemoveSpaces(name)

            ColorPickerZIndex = ColorPickerZIndex + 1

            local ColorPickerOpen = false
            local RainbowColorMode = false
            
            local Color = nil
            local ColorValue = 0
            local RainbowColor = nil

            ColorPickerHolder.Name = (ColorPickerName .. "ColorPickerHolder")
            ColorPickerHolder.Parent = Section1Holder
            ColorPickerHolder.BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255)
            ColorPickerHolder.BorderSizePixel = 0
            ColorPickerHolder.Size = UDim2.new(0, 170, 0, 30)

            ColorPickerTitle.Name = "ColorPickerTitle"
            ColorPickerTitle.Parent = ColorPickerHolder
            ColorPickerTitle.BackgroundColor3 = Color3.new(1, 1, 1)
            ColorPickerTitle.BackgroundTransparency = 1
            ColorPickerTitle.BorderSizePixel = 0
            ColorPickerTitle.Position = UDim2.new(0.052941177, 0, 0, 0)
            ColorPickerTitle.Size = UDim2.new(0, 125, 0, 30)
            ColorPickerTitle.Font = Enum.Font.SourceSansBold
            ColorPickerTitle.Text = name
            ColorPickerTitle.TextColor3 = Color3.new(1, 1, 1)
            ColorPickerTitle.TextSize = 17
            ColorPickerTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            ColorPickerToggle.Name = "ColorPickerToggle"
            ColorPickerToggle.Parent = ColorPickerHolder
            ColorPickerToggle.BackgroundColor3 = Color3.new(1, 1, 1)
            ColorPickerToggle.BackgroundTransparency = 1
            ColorPickerToggle.Position = UDim2.new(0.822000027, 0, 0.166999996, 0)
            ColorPickerToggle.Size = UDim2.new(0, 22, 0, 20)
            ColorPickerToggle.Image = "rbxassetid://3570695787"
            ColorPickerToggle.ImageColor3 = presetcolor
            ColorPickerToggle.ScaleType = Enum.ScaleType.Slice
            ColorPickerToggle.SliceCenter = Rect.new(100, 100, 100, 100)
            ColorPickerToggle.SliceScale = 0.04
            
            ColorPickerMain.Name = "ColorPickerMain"
            ColorPickerMain.Parent = ColorPickerHolder
            ColorPickerMain.BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255)
            ColorPickerMain.BackgroundTransparency = 1
            ColorPickerMain.ClipsDescendants = true
            ColorPickerMain.BorderSizePixel = 0
            ColorPickerMain.Position = UDim2.new(1.04705882, 0, -1.36666667, 0)
            ColorPickerMain.Size = UDim2.new(0, 0, 0, 175)
            ColorPickerMain.Image = "rbxassetid://3570695787"
            ColorPickerMain.ImageColor3 = Color3.new(0.137255, 0.137255, 0.137255)
            ColorPickerMain.ScaleType = Enum.ScaleType.Slice
            ColorPickerMain.SliceCenter = Rect.new(100, 100, 100, 100)
            ColorPickerMain.SliceScale = 0.05
            ColorPickerMain.ZIndex = 1 + ColorPickerZIndex
            
            RainbowToggleHolder.Name = "RainbowToggleHolder"
            RainbowToggleHolder.Parent = ColorPickerMain
            RainbowToggleHolder.BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255)
            RainbowToggleHolder.BackgroundTransparency = 1
            RainbowToggleHolder.BorderSizePixel = 0
            RainbowToggleHolder.Position = UDim2.new(0, 0, 0.819999993, 0)
            RainbowToggleHolder.Size = UDim2.new(0, 170, 0, 30)
            RainbowToggleHolder.ZIndex = 1 + ColorPickerZIndex

            RainbowTitle.Name = "RainbowTitle"
            RainbowTitle.Parent = RainbowToggleHolder
            RainbowTitle.BackgroundColor3 = Color3.new(1, 1, 1)
            RainbowTitle.BackgroundTransparency = 1
            RainbowTitle.BorderSizePixel = 0
            RainbowTitle.Position = UDim2.new(0.052941177, 0, 0, 0)
            RainbowTitle.Size = UDim2.new(0, 125, 0, 30)
            RainbowTitle.Font = Enum.Font.SourceSansBold
            RainbowTitle.Text = "Rainbow"
            RainbowTitle.TextColor3 = Color3.new(1, 1, 1)
            RainbowTitle.TextSize = 17
            RainbowTitle.TextXAlignment = Enum.TextXAlignment.Left
            RainbowTitle.ZIndex = 1 + ColorPickerZIndex

            RainbowBackground.Name = "RainbowBackground"
            RainbowBackground.Parent = RainbowToggleHolder
            RainbowBackground.BackgroundColor3 = Color3.new(1, 1, 1)
            RainbowBackground.BackgroundTransparency = 1
            RainbowBackground.BorderSizePixel = 0
            RainbowBackground.Position = UDim2.new(0.847058833, 0, 0.166666672, 0)
            RainbowBackground.Size = UDim2.new(0, 20, 0, 20)
            RainbowBackground.Image = "rbxassetid://3570695787"
            RainbowBackground.ImageColor3 = Color3.new(0.254902, 0.254902, 0.254902)
            RainbowBackground.ZIndex = 1 + ColorPickerZIndex

            RainbowToggleButton.Name = "RainbowToggleButton"
            RainbowToggleButton.Parent = RainbowBackground
            RainbowToggleButton.BackgroundColor3 = Color3.new(1, 1, 1)
            RainbowToggleButton.BackgroundTransparency = 1
            RainbowToggleButton.Position = UDim2.new(0, 2, 0, 2)
            RainbowToggleButton.Size = UDim2.new(0, 16, 0, 16)
            RainbowToggleButton.Image = "rbxassetid://3570695787"
            RainbowToggleButton.ImageColor3 = Color3.new(1, 0.341176, 0.341176)
            RainbowToggleButton.ImageTransparency = 1
            RainbowToggleButton.ZIndex = 1 + ColorPickerZIndex

            ColorValueR.Name = "ColorValueR"
            ColorValueR.Parent = ColorPickerMain
            ColorValueR.BackgroundColor3 = Color3.new(0.254902, 0.254902, 0.254902)
            ColorValueR.BackgroundTransparency = 1
            ColorValueR.BorderSizePixel = 0
            ColorValueR.ClipsDescendants = true
            ColorValueR.Position = UDim2.new(0, 7, 0, 127)
            ColorValueR.Size = UDim2.new(0, 50, 0, 16)
            ColorValueR.ZIndex = 2 + ColorPickerZIndex
            ColorValueR.Font = Enum.Font.SourceSansBold
            ColorValueR.Text = "R: 000"
            ColorValueR.TextColor3 = Color3.new(1, 1, 1)
            ColorValueR.TextSize = 14

            ColorValueRRound.Name = "ColorValueRRound"
            ColorValueRRound.Parent = ColorValueR
            ColorValueRRound.Active = true
            ColorValueRRound.AnchorPoint = Vector2.new(0.5, 0.5)
            ColorValueRRound.BackgroundColor3 = Color3.new(1, 1, 1)
            ColorValueRRound.BackgroundTransparency = 1
            ColorValueRRound.Position = UDim2.new(0.5, 0, 0.5, 0)
            ColorValueRRound.Selectable = true
            ColorValueRRound.Size = UDim2.new(1, 0, 1, 0)
            ColorValueRRound.Image = "rbxassetid://3570695787"
            ColorValueRRound.ImageColor3 = Color3.new(0.254902, 0.254902, 0.254902)
            ColorValueRRound.ScaleType = Enum.ScaleType.Slice
            ColorValueRRound.SliceCenter = Rect.new(100, 100, 100, 100)
            ColorValueRRound.SliceScale = 0.04
            ColorValueRRound.ZIndex = 1 + ColorPickerZIndex

            ColorValueG.Name = "ColorValueG"
            ColorValueG.Parent = ColorPickerMain
            ColorValueG.BackgroundColor3 = Color3.new(0.254902, 0.254902, 0.254902)
            ColorValueG.BackgroundTransparency = 1
            ColorValueG.BorderSizePixel = 0
            ColorValueG.ClipsDescendants = true
            ColorValueG.Position = UDim2.new(0, 60, 0, 127)
            ColorValueG.Size = UDim2.new(0, 51, 0, 16)
            ColorValueG.ZIndex = 2 + ColorPickerZIndex
            ColorValueG.Font = Enum.Font.SourceSansBold
            ColorValueG.Text = "G: 000"
            ColorValueG.TextColor3 = Color3.new(1, 1, 1)
            ColorValueG.TextSize = 14

            ColorValueGRound.Name = "ColorValueGRound"
            ColorValueGRound.Parent = ColorValueG
            ColorValueGRound.Active = true
            ColorValueGRound.AnchorPoint = Vector2.new(0.5, 0.5)
            ColorValueGRound.BackgroundColor3 = Color3.new(1, 1, 1)
            ColorValueGRound.BackgroundTransparency = 1
            ColorValueGRound.Position = UDim2.new(0.5, 0, 0.5, 0)
            ColorValueGRound.Selectable = true
            ColorValueGRound.Size = UDim2.new(1, 0, 1, 0)
            ColorValueGRound.Image = "rbxassetid://3570695787"
            ColorValueGRound.ImageColor3 = Color3.new(0.254902, 0.254902, 0.254902)
            ColorValueGRound.ScaleType = Enum.ScaleType.Slice
            ColorValueGRound.SliceCenter = Rect.new(100, 100, 100, 100)
            ColorValueGRound.SliceScale = 0.04
            ColorValueGRound.ZIndex = 1 + ColorPickerZIndex

            ColorValueB.Name = "ColorValueB"
            ColorValueB.Parent = ColorPickerMain
            ColorValueB.BackgroundColor3 = Color3.new(0.254902, 0.254902, 0.254902)
            ColorValueB.BackgroundTransparency = 1
            ColorValueB.BorderSizePixel = 0
            ColorValueB.ClipsDescendants = true
            ColorValueB.Position = UDim2.new(0, 114, 0, 127)
            ColorValueB.Size = UDim2.new(0, 50, 0, 16)
            ColorValueB.ZIndex = 2 + ColorPickerZIndex
            ColorValueB.Font = Enum.Font.SourceSansBold
            ColorValueB.Text = "B: 000"
            ColorValueB.TextColor3 = Color3.new(1, 1, 1)
            ColorValueB.TextSize = 14

            ColorValueBRound.Name = "ColorValueBRound"
            ColorValueBRound.Parent = ColorValueB
            ColorValueBRound.Active = true
            ColorValueBRound.AnchorPoint = Vector2.new(0.5, 0.5)
            ColorValueBRound.BackgroundColor3 = Color3.new(1, 1, 1)
            ColorValueBRound.BackgroundTransparency = 1
            ColorValueBRound.Position = UDim2.new(0.5, 0, 0.5, 0)
            ColorValueBRound.Selectable = true
            ColorValueBRound.Size = UDim2.new(1, 0, 1, 0)
            ColorValueBRound.Image = "rbxassetid://3570695787"
            ColorValueBRound.ImageColor3 = Color3.new(0.254902, 0.254902, 0.254902)
            ColorValueBRound.ScaleType = Enum.ScaleType.Slice
            ColorValueBRound.SliceCenter = Rect.new(100, 100, 100, 100)
            ColorValueBRound.SliceScale = 0.04
            ColorValueBRound.ZIndex = 1 + ColorPickerZIndex

            RoundHueHolder.Name = "RoundHueHolder"
            RoundHueHolder.Parent = ColorPickerMain
            RoundHueHolder.BackgroundColor3 = Color3.new(1, 1, 1)
            RoundHueHolder.BackgroundTransparency = 1
            RoundHueHolder.ClipsDescendants = true
            RoundHueHolder.Position = UDim2.new(0, 136, 0, 6)
            RoundHueHolder.Size = UDim2.new(0, 28, 0, 114)
            RoundHueHolder.ZIndex = 2 + ColorPickerZIndex
            RoundHueHolder.Image = "rbxassetid://4695575676"
            RoundHueHolder.ImageColor3 = Color3.new(0.137255, 0.137255, 0.137255)
            RoundHueHolder.ScaleType = Enum.ScaleType.Slice
            RoundHueHolder.SliceCenter = Rect.new(128, 128, 128, 128)
            RoundHueHolder.SliceScale = 0.05

            ColorHue.Name = "ColorHue"
            ColorHue.Parent = RoundHueHolder
            ColorHue.BackgroundColor3 = Color3.new(1, 1, 1)
            ColorHue.BackgroundTransparency = 1
            ColorHue.BorderSizePixel = 0
            ColorHue.Size = UDim2.new(0, 28, 0, 114)
            ColorHue.Image = "http://www.roblox.com/asset/?id=4801885250"
            ColorHue.ScaleType = Enum.ScaleType.Crop
            ColorHue.ZIndex = 1 + ColorPickerZIndex

            HueMarker.Name = "HueMarker"
            HueMarker.Parent = RoundHueHolder
            HueMarker.BackgroundColor3 = Color3.new(0.294118, 0.294118, 0.294118)
            HueMarker.BorderSizePixel = 0
            HueMarker.Position = UDim2.new(-0.25, 0, 0, 0)
            HueMarker.Size = UDim2.new(0, 42, 0, 5)
            HueMarker.ZIndex = 1 + ColorPickerZIndex

            RoundSaturationHolder.Name = "RoundSaturationHolder"
            RoundSaturationHolder.Parent = ColorPickerMain
            RoundSaturationHolder.BackgroundColor3 = Color3.new(1, 1, 1)
            RoundSaturationHolder.BackgroundTransparency = 1
            RoundSaturationHolder.ClipsDescendants = true
            RoundSaturationHolder.Position = UDim2.new(0, 7, 0, 6)
            RoundSaturationHolder.Size = UDim2.new(0, 122, 0, 114)
            RoundSaturationHolder.ZIndex = 2 + ColorPickerZIndex
            RoundSaturationHolder.Image = "rbxassetid://4695575676"
            RoundSaturationHolder.ImageColor3 = Color3.new(0.137255, 0.137255, 0.137255)
            RoundSaturationHolder.ScaleType = Enum.ScaleType.Slice
            RoundSaturationHolder.SliceCenter = Rect.new(128, 128, 128, 128)
            RoundSaturationHolder.SliceScale = 0.05

            ColorSelector.Name = "ColorSelector"
            ColorSelector.Parent = RoundSaturationHolder
            ColorSelector.BackgroundColor3 = presetcolor
            ColorSelector.BorderSizePixel = 0
            ColorSelector.Size = UDim2.new(0, 122, 0, 114)
            ColorSelector.Image = "rbxassetid://4805274903"
            ColorSelector.ZIndex = 1 + ColorPickerZIndex

            SaturationMarker.Name = "SaturationMarker"
            SaturationMarker.Parent = RoundSaturationHolder
            SaturationMarker.BackgroundColor3 = Color3.new(1, 1, 1)
            SaturationMarker.BackgroundTransparency = 1
            SaturationMarker.Size = UDim2.new(0, 0, 0, 0)
            SaturationMarker.Image = "http://www.roblox.com/asset/?id=4805639000"
            SaturationMarker.ZIndex = 1 + ColorPickerZIndex

            local function SetRGBValues()
                local RedValue, GreenValue, BlueValue = ColorPickerToggle.ImageColor3.r * 255, ColorPickerToggle.ImageColor3.g * 255, ColorPickerToggle.ImageColor3.b * 255

                ColorValueR.Text = ("R: " .. math.floor(RedValue))
                ColorValueG.Text = ("G: " .. math.floor(GreenValue))
                ColorValueB.Text = ("B: " .. math.floor(BlueValue))
            end

            SetRGBValues()

            ColorPickerToggle.MouseButton1Down:Connect(function()
                if not ColorPickerOpen then
                    ColorPickerOpen = true
                    Body.ClipsDescendants = false
                    Section1Holder.ClipsDescendants = false

                    TweenService:Create(ColorPickerMain, TweenInfo.new(0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 171, 0, 175)}):Play()
                elseif ColorPickerOpen then
                    ColorPickerOpen = false
                    TweenService:Create(ColorPickerMain, TweenInfo.new(0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 175)}):Play()
                end
            end)

            local ColorData = {
                H = 1;
                S = 1;
                V = 1
            }

            local Connection1 = nil
            local Connection2 = nil

            local function GetXY(frame)
                local X, Y = Mouse.X - frame.AbsolutePosition.X, Mouse.Y - frame.AbsolutePosition.Y
                local MaxX, MaxY = frame.AbsoluteSize.X, frame.AbsoluteSize.Y
                X = math.clamp(X, 0, MaxX)
                Y = math.clamp(Y, 0, MaxY)
                return X / MaxX, Y / MaxY
            end

            local function GetY(frame)
                local Y2 = Mouse.Y - frame.AbsolutePosition.Y
                MaxY2 = frame.AbsoluteSize.Y
                Y2 = math.clamp(Y2, -10, MaxY2)
                return Y2 / MaxY2
            end

            local function Update()
                SetRGBValues()

                Color = Color3.fromHSV(ColorData.H, ColorData.S, ColorData.V)

                ColorPickerToggle.ImageColor3 = Color
                ColorSelector.BackgroundColor3 = Color3.fromHSV(ColorData.H, 1, 1)
                action(ColorPickerToggle.ImageColor3)
            end

            ColorSelector.MouseLeave:Connect(function()
                if Connection1 then
                    Connection1:Disconnect()
                    Connection1 = nil
                end
                if Connection2 then
                    Connection2:Disconnect()
                    Connection2 = nil
                end
            end)

            ColorHue.MouseLeave:Connect(function()
                if Connection1 then
                    Connection1:Disconnect()
                    Connection1 = nil
                end
                if Connection2 then
                    Connection2:Disconnect()
                    Connection2 = nil
                end
            end)

            RainbowToggleButton.MouseButton1Down:Connect(function()
                if not RainbowColorMode then
                    RainbowColorMode = true
                    TweenService:Create(RainbowToggleButton, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
                elseif RainbowColorMode then
                    RainbowColorMode = false
                    TweenService:Create(RainbowToggleButton, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
                end

                while RainbowColorMode do
                    RainbowColor = Color3.fromHSV(RainbowModeColorValue, 1, 1)

                    ColorPickerToggle.ImageColor3 = RainbowColor
                    ColorSelector.BackgroundColor3 = RainbowColor

                    action(RainbowColor)
                    SetRGBValues()
                    wait()
                end
            end)

            ColorSelector.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if not RainbowColorMode then
                        if Connection1 then
                            Connection1:Disconnect()
                        end
                        Connection1 = RunService.RenderStepped:Connect(function()
                            local X, Y = GetXY(RoundSaturationHolder)

                            SaturationMarker.Position = UDim2.new(X, 0, Y, 0)
                            ColorData.S = X
                            ColorData.V = 1 - Y
                            Update()
                        end)
                    end
                end
            end)

            ColorSelector.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if Connection1 then
                        Connection1:Disconnect()
                    end
                end
            end)

            ColorHue.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if not RainbowColorMode then
                        if Connection2 then
                            Connection2:Disconnect()
                        end

                        Connection2 = RunService.RenderStepped:Connect(function()
                            local X, Y = GetXY(RoundHueHolder)
                            local Y2 = GetY(RoundHueHolder)

                            ColorData.H = 1 - Y
                            TweenService:Create(HueMarker, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(-0.25, 0, Y2, 0)}):Play()
                            Update()
                        end)
                    end
                end
            end)

            ColorHue.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if Connection2 then
                        Connection2:Disconnect()
                    end
                end
            end)

            SectionToggle.MouseButton1Down:Connect(function()
                if not IsSectionOpen then
                    Body.ClipsDescendants = true
                    Section1Holder.ClipsDescendants = true

                    ExtendSectionSize(30)
                    ExtendBodySize(30)
                elseif IsSectionOpen then
                    ColorPickerOpen = false
                    TweenService:Create(ColorPickerMain, TweenInfo.new(0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 175)}):Play()

                    Body.ClipsDescendants = true
                    Section1Holder.ClipsDescendants = true

                    UnExtendSectionSize(30)
                    UnExtendBodySize(30)
                end
            end)

            WindowToggle.MouseButton1Down:Connect(function()
                ColorPickerOpen = false
                TweenService:Create(ColorPickerMain, TweenInfo.new(0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 175)}):Play()

                Body.ClipsDescendants = true
                Section1Holder.ClipsDescendants = true

                if not IsTabOpen then
                    if IsSectionOpen then
                        ExtendBodySize(30)
                        TweenService:Create(SectionToggle, TweenInfo.new(0, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 360}):Play()
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                    elseif not IsSectionOpen then
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                    end

                    
                elseif IsTabOpen then
                    if IsSectionOpen then
                        UnExtendBodySize(30)
                        TweenService:Create(SectionToggle, TweenInfo.new(0, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    elseif not IsSectionOpen then
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    end
                end

                TweenService:Create(SectionToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
        
                SectionToggle.Visible = false
        
                repeat wait() until SectionToggle.TextTransparency == 1
                SectionToggle.Visible = true
                TweenService:Create(SectionToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
            end)
        end

        function LibraryElements:CreateButton(name, action)
            local ButtonHolder = Instance.new("Frame")
            local Button = Instance.new("TextButton")
            local ButtonRound = Instance.new("ImageLabel")

            local ButtonName = RemoveSpaces(name)

            ButtonHolder.Name = (ButtonName .. "ButtonHolder")
            ButtonHolder.Parent = Section1Holder
            ButtonHolder.BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255)
            ButtonHolder.BorderSizePixel = 0
            ButtonHolder.Size = UDim2.new(0, 170, 0, 30)
            
            Button.Name = "Button"
            Button.Parent = ButtonHolder
            Button.BackgroundColor3 = Color3.new(0.254902, 0.254902, 0.254902)
            Button.BackgroundTransparency = 1
            Button.BorderSizePixel = 0
            Button.Position = UDim2.new(0.052941177, 0, 0, 0)
            Button.Size = UDim2.new(0, 153, 0, 24)
            Button.ZIndex = 2
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.SourceSansBold
            Button.Text = name
            Button.TextColor3 = Color3.new(1, 1, 1)
            Button.TextSize = 14
            
            ButtonRound.Name = "ButtonRound"
            ButtonRound.Parent = Button
            ButtonRound.Active = true
            ButtonRound.AnchorPoint = Vector2.new(0.5, 0.5)
            ButtonRound.BackgroundColor3 = Color3.new(1, 1, 1)
            ButtonRound.BackgroundTransparency = 1
            ButtonRound.BorderSizePixel = 0
            ButtonRound.ClipsDescendants = true
            ButtonRound.Position = UDim2.new(0.5, 0, 0.5, 0)
            ButtonRound.Selectable = true
            ButtonRound.Size = UDim2.new(1, 0, 1, 0)
            ButtonRound.Image = "rbxassetid://3570695787"
            ButtonRound.ImageColor3 = Color3.new(0.254902, 0.254902, 0.254902)
            ButtonRound.ScaleType = Enum.ScaleType.Slice
            ButtonRound.SliceCenter = Rect.new(100, 100, 100, 100)
            ButtonRound.SliceScale = 0.04

            Button.MouseButton1Down:Connect(function()
                action(Button)
            end)
            
            SectionToggle.MouseButton1Down:Connect(function()
                if not IsSectionOpen then
                    ExtendSectionSize(30)
                    ExtendBodySize(30)
                elseif IsSectionOpen then
                    UnExtendSectionSize(30)
                    UnExtendBodySize(30)
                end
            end)

            WindowToggle.MouseButton1Down:Connect(function()
                if not IsTabOpen then
                    if IsSectionOpen then
                        ExtendBodySize(30)
                        TweenService:Create(SectionToggle, TweenInfo.new(0, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 360}):Play()
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                    elseif not IsSectionOpen then
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                    end

                    
                elseif IsTabOpen then
                    if IsSectionOpen then
                        UnExtendBodySize(30)
                        TweenService:Create(SectionToggle, TweenInfo.new(0, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    elseif not IsSectionOpen then
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    end
                end

                TweenService:Create(SectionToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
        
                SectionToggle.Visible = false
        
                repeat wait() until SectionToggle.TextTransparency == 1
                SectionToggle.Visible = true
                TweenService:Create(SectionToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
            end)
        end

        function LibraryElements:CreateTextbox(name, action)
            local TextBoxHolder = Instance.new("Frame")
            local TextBox = Instance.new("TextBox")
            local TextBoxRound = Instance.new("ImageLabel")

            local TextBoxName = RemoveSpaces(name)

            TextBoxHolder.Name = (TextBoxName .. "TextBoxHolder")
            TextBoxHolder.Parent = Section1Holder
            TextBoxHolder.BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255)
            TextBoxHolder.BorderSizePixel = 0
            TextBoxHolder.Size = UDim2.new(0, 170, 0, 30)
            
            TextBox.Parent = TextBoxHolder
            TextBox.BackgroundColor3 = Color3.new(0.254902, 0.254902, 0.254902)
            TextBox.BackgroundTransparency = 1
            TextBox.ClipsDescendants = true
            TextBox.Position = UDim2.new(0.0529999994, 0, 0, 0)
            TextBox.Size = UDim2.new(0, 153, 0, 24)
            TextBox.ZIndex = 2
            TextBox.Font = Enum.Font.SourceSansBold
            TextBox.PlaceholderText = name
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.new(1, 1, 1)
            TextBox.TextSize = 14
            
            TextBoxRound.Name = "TextBoxRound"
            TextBoxRound.Parent = TextBox
            TextBoxRound.Active = true
            TextBoxRound.AnchorPoint = Vector2.new(0.5, 0.5)
            TextBoxRound.BackgroundColor3 = Color3.new(1, 1, 1)
            TextBoxRound.BackgroundTransparency = 1
            TextBoxRound.BorderSizePixel = 0
            TextBoxRound.ClipsDescendants = true
            TextBoxRound.Position = UDim2.new(0.5, 0, 0.5, 0)
            TextBoxRound.Selectable = true
            TextBoxRound.Size = UDim2.new(1, 0, 1, 0)
            TextBoxRound.Image = "rbxassetid://3570695787"
            TextBoxRound.ImageColor3 = Color3.new(0.254902, 0.254902, 0.254902)
            TextBoxRound.ScaleType = Enum.ScaleType.Slice
            TextBoxRound.SliceCenter = Rect.new(100, 100, 100, 100)
            TextBoxRound.SliceScale = 0.04

            TextBox.FocusLost:Connect(function(enterPressed)
                if enterPressed then
                    action(TextBox.Text)
                end
            end)

            SectionToggle.MouseButton1Down:Connect(function()
                if not IsSectionOpen then
                    ExtendSectionSize(30)
                    ExtendBodySize(30)
                elseif IsSectionOpen then
                    UnExtendSectionSize(30)
                    UnExtendBodySize(30)
                end
            end)

            WindowToggle.MouseButton1Down:Connect(function()
                if not IsTabOpen then
                    if IsSectionOpen then
                        ExtendBodySize(30)
                        TweenService:Create(SectionToggle, TweenInfo.new(0, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 360}):Play()
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                    elseif not IsSectionOpen then
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                    end

                    
                elseif IsTabOpen then
                    if IsSectionOpen then
                        UnExtendBodySize(30)
                        TweenService:Create(SectionToggle, TweenInfo.new(0, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    elseif not IsSectionOpen then
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    end
                end

                TweenService:Create(SectionToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
        
                SectionToggle.Visible = false
        
                repeat wait() until SectionToggle.TextTransparency == 1
                SectionToggle.Visible = true
                TweenService:Create(SectionToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
            end)
        end

        function LibraryElements:CreateDropdown(name, options, presetoption, action)
            local DropdownHolder = Instance.new("Frame")
            local DropdownTitle = Instance.new("TextLabel")
            local DropdownRound = Instance.new("ImageLabel")
            local DropdownToggle = Instance.new("TextButton")
            local DropdownMain = Instance.new("ImageLabel")
            local ScrollingFrame = Instance.new("ScrollingFrame")
            local ButtonLayout = Instance.new("UIListLayout")

            local DropdownName = RemoveSpaces(name)

            local StartingCanvasSize = 1
            local StartScrollingFrame = false

            local SelectedOptionName = options[presetoption]
            local NumberOfOptions = 0
            local DropdownYSize = 0
            local IsDropdownWindowOpen = false

            DropdownHolder.Name = (DropdownName .. "DropdownHolder")
            DropdownHolder.Parent = Section1Holder
            DropdownHolder.BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255)
            DropdownHolder.BorderSizePixel = 0
            DropdownHolder.Size = UDim2.new(0, 170, 0, 30)
            
            DropdownTitle.Name = "DropdownTitle"
            DropdownTitle.Parent = DropdownHolder
            DropdownTitle.BackgroundColor3 = Color3.new(0.254902, 0.254902, 0.254902)
            DropdownTitle.BackgroundTransparency = 1
            DropdownTitle.BorderSizePixel = 0
            DropdownTitle.Position = UDim2.new(0.0529999994, 0, 0, 0)
            DropdownTitle.Size = UDim2.new(0, 153, 0, 24)
            DropdownTitle.ZIndex = 2
            DropdownTitle.Font = Enum.Font.SourceSansBold
            DropdownTitle.Text = SelectedOptionName
            DropdownTitle.TextColor3 = Color3.new(1, 1, 1)
            DropdownTitle.TextSize = 14
            
            DropdownRound.Name = "DropdownRound"
            DropdownRound.Parent = DropdownTitle
            DropdownRound.Active = true
            DropdownRound.AnchorPoint = Vector2.new(0.5, 0.5)
            DropdownRound.BackgroundColor3 = Color3.new(1, 1, 1)
            DropdownRound.BackgroundTransparency = 1
            DropdownRound.BorderSizePixel = 0
            DropdownRound.ClipsDescendants = true
            DropdownRound.Position = UDim2.new(0.5, 0, 0.5, 0)
            DropdownRound.Selectable = true
            DropdownRound.Size = UDim2.new(1, 0, 1, 0)
            DropdownRound.Image = "rbxassetid://3570695787"
            DropdownRound.ImageColor3 = Color3.new(0.254902, 0.254902, 0.254902)
            DropdownRound.ScaleType = Enum.ScaleType.Slice
            DropdownRound.SliceCenter = Rect.new(100, 100, 100, 100)
            DropdownRound.SliceScale = 0.04

            DropdownToggle.Name = "DropdownToggle"
            DropdownToggle.Parent = DropdownTitle
            DropdownToggle.BackgroundColor3 = Color3.new(1, 1, 1)
            DropdownToggle.BackgroundTransparency = 1
            DropdownToggle.Position = UDim2.new(0.816928029, 0, 0, 0)
            DropdownToggle.Size = UDim2.new(0, 28, 0, 24)
            DropdownToggle.AutoButtonColor = false
            DropdownToggle.Font = Enum.Font.SourceSansBold
            DropdownToggle.Text = ">"
            DropdownToggle.TextColor3 = Color3.new(1, 1, 1)
            DropdownToggle.TextSize = 15
            
            DropdownMain.Name = "DropdownMain"
            DropdownMain.Parent = DropdownTitle
            DropdownMain.BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255)
            DropdownMain.BackgroundTransparency = 1
            DropdownMain.ClipsDescendants = true
            DropdownMain.Position = UDim2.new(1.09275186, 0, -0.0336658955, 0)
            DropdownMain.Size = UDim2.new(0, 0, 0, DropdownYSize)
            DropdownMain.Image = "rbxassetid://3570695787"
            DropdownMain.ImageColor3 = Color3.new(0.137255, 0.137255, 0.137255)
            DropdownMain.ScaleType = Enum.ScaleType.Slice
            DropdownMain.SliceCenter = Rect.new(100, 100, 100, 100)
            DropdownMain.SliceScale = 0.04

            ScrollingFrame.Parent = DropdownMain
            ScrollingFrame.BackgroundColor3 = Color3.new(1, 1, 1)
            ScrollingFrame.BackgroundTransparency = 1
            ScrollingFrame.BorderSizePixel = 0
            ScrollingFrame.Size = UDim2.new(0, 153, 0, DropdownYSize)
            ScrollingFrame.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
            ScrollingFrame.CanvasSize = UDim2.new(0, 0, StartingCanvasSize, 0)
            ScrollingFrame.ScrollBarThickness = 3
            ScrollingFrame.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
            ScrollingFrame.ScrollingDirection = "Y"

            ButtonLayout.Name = "ButtonLayout"
            ButtonLayout.Parent = ScrollingFrame
            ButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder

            for i, v in pairs(options) do
                local DropdownOption = Instance.new("TextButton")
    
                NumberOfOptions = NumberOfOptions + 1

                local DropdownButtonName = RemoveSpaces(v)

                DropdownOption.Name = (DropdownButtonName .. "Button")
                DropdownOption.Parent = ScrollingFrame
                DropdownOption.BackgroundColor3 = Color3.new(0.215686, 0.215686, 0.215686)
                DropdownOption.BackgroundTransparency = 1
                DropdownOption.BorderSizePixel = 0
                DropdownOption.Position = UDim2.new(0, 0, 0, 0)
                DropdownOption.Size = UDim2.new(0, 153, 0, 25)
                DropdownOption.AutoButtonColor = false
                DropdownOption.Font = Enum.Font.SourceSansBold
                DropdownOption.Text = v
                DropdownOption.TextColor3 = Color3.new(1, 1, 1)
                DropdownOption.TextSize = 14

                if NumberOfOptions <= 4 then
                    DropdownYSize = DropdownYSize + 25
                    DropdownMain.Size = UDim2.new(0, 0, 0, DropdownYSize)
                elseif NumberOfOptions >= 4 then
                    StartScrollingFrame = true
                end

                if StartScrollingFrame then
                    StartingCanvasSize = StartingCanvasSize + 0.25
                    ScrollingFrame.CanvasSize = UDim2.new(0, 0, StartingCanvasSize, 0)
                end

                DropdownOption.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        TweenService:Create(DropdownOption, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0.5}):Play()
                    end
                end)
                    
                DropdownOption.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        TweenService:Create(DropdownOption, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    end
                end)

                DropdownOption.MouseButton1Down:Connect(function()
                    SelectedOptionName = v
                    action(v)

                    IsDropdownWindowOpen = false

                    DropdownToggle.Text = ">"
                    TweenService:Create(DropdownToggle, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()

                    TweenService:Create(DropdownTitle, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.new(1, 1, 1)}):Play()
                    DropdownTitle.Text = SelectedOptionName

                    TweenService:Create(ScrollingFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ScrollBarImageTransparency = 1}):Play()
                    TweenService:Create(ScrollingFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, DropdownYSize)}):Play()

                    TweenService:Create(DropdownMain, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, DropdownYSize)}):Play()
                end)
            end
    
            DropdownToggle.MouseButton1Down:Connect(function()
                if IsDropdownWindowOpen then
                    IsDropdownWindowOpen = false

                    DropdownToggle.Text = ">"
                    TweenService:Create(DropdownToggle, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()

                    TweenService:Create(DropdownTitle, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.new(1, 1, 1)}):Play()
                    DropdownTitle.Text = SelectedOptionName

                    TweenService:Create(ScrollingFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ScrollBarImageTransparency = 1}):Play()
                    TweenService:Create(ScrollingFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, DropdownYSize)}):Play()

                    TweenService:Create(DropdownMain, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, DropdownYSize)}):Play()
                elseif not IsDropdownWindowOpen then
                    Body.ClipsDescendants = false
                    Section1Holder.ClipsDescendants = false

                    IsDropdownWindowOpen = true

                    DropdownToggle.Text = "<"
                    TweenService:Create(DropdownToggle, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = -360}):Play()

                    TweenService:Create(DropdownTitle, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.new(0.698039, 0.698039, 0.698039)}):Play()
                    DropdownTitle.Text = name

                    TweenService:Create(ScrollingFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ScrollBarImageTransparency = 0}):Play()
                    TweenService:Create(ScrollingFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 153, 0, DropdownYSize)}):Play()

                    TweenService:Create(DropdownMain, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 153, 0, DropdownYSize)}):Play()
                end
            end)

            SectionToggle.MouseButton1Down:Connect(function()
                if not IsSectionOpen then
                    ExtendSectionSize(30)
                    ExtendBodySize(30)
                elseif IsSectionOpen then
                    IsDropdownWindowOpen = false

                    DropdownToggle.Text = ">"
                    TweenService:Create(DropdownToggle, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()

                    TweenService:Create(DropdownTitle, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.new(1, 1, 1)}):Play()
                    DropdownTitle.Text = SelectedOptionName

                    TweenService:Create(ScrollingFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ScrollBarImageTransparency = 1}):Play()
                    TweenService:Create(ScrollingFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0)}):Play()

                    TweenService:Create(DropdownMain, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, DropdownYSize)}):Play()
                    
                    Body.ClipsDescendants = true
                    Section1Holder.ClipsDescendants = true

                    UnExtendSectionSize(30)
                    UnExtendBodySize(30)
                end
            end)

            WindowToggle.MouseButton1Down:Connect(function()
                IsDropdownWindowOpen = false

                DropdownToggle.Text = ">"
                TweenService:Create(DropdownToggle, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()

                TweenService:Create(DropdownTitle, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.new(1, 1, 1)}):Play()

                DropdownTitle.Text = SelectedOptionName
                TweenService:Create(ScrollingFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ScrollBarImageTransparency = 1}):Play()
                TweenService:Create(ScrollingFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, DropdownYSize)}):Play()

                TweenService:Create(DropdownMain, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, DropdownYSize)}):Play()
                
                Body.ClipsDescendants = true
                Section1Holder.ClipsDescendants = true

                if not IsTabOpen then
                    if IsSectionOpen then
                        ExtendBodySize(30)
                        TweenService:Create(SectionToggle, TweenInfo.new(0, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = -360}):Play()
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                    elseif not IsSectionOpen then
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                    end

                    
                elseif IsTabOpen then
                    if IsSectionOpen then
                        UnExtendBodySize(30)
                        TweenService:Create(SectionToggle, TweenInfo.new(0, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    elseif not IsSectionOpen then
                        TweenService:Create(Section1Holder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    end
                end

                TweenService:Create(SectionToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
        
                SectionToggle.Visible = false
        
                repeat wait() until SectionToggle.TextTransparency == 1
                SectionToggle.Visible = true
                TweenService:Create(SectionToggle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
            end)
        end

        return LibraryElements
    end

    return Sections
end

--MAIN


function findplayer(stringg)
    for _, v in pairs(game.Players:GetPlayers()) do
        if stringg:lower() == (v.Name:lower()):sub(1, #stringg) then
            return v
        elseif stringg:lower() == (v.DisplayName:lower()):sub(1, #stringg) then
            return v
        end
    end
end

local PrisonLifeWindow = Library:NewWindow("Prison Life")

local MainCheatsSection = PrisonLifeWindow:NewSection("Main Cheats")

getgenv().godmode = false
getgenv().noclip = false
getgenv().alerts = false
getgenv().changedwalkspeed = false
getgenv().walkspeed = 0
getgenv().changedjumppower = false
getgenv().jumppower = 0
getgenv().changedhipheight = false
getgenv().hipheight = 0
getgenv().onepunch = false


MainCheatsSection:CreateToggle("Noclip", function(enabled)
	if enabled then 
        game:GetService('StarterGui'):SetCore('SendNotification',{
            Title = 'KN HUB',
            Text = 'if noclip doesnt work first time re select the option.',
            Duration = 15,
            })

        noclip = not noclip
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
           
    
    
	elseif not enabled then
        noclip = false
        game:GetService('RunService').Stepped:connect(function()
        if noclip then
        game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
        end
        end)
        plr = game.Players.LocalPlayer
        mouse = plr:GetMouse()
    end
print('Loaded')

end)



MainCheatsSection:CreateButton("Give All Items", function()
    for i,v in pairs(game.Workspace.Prison_ITEMS.single:GetChildren()) do
        if v:FindFirstChild("ITEMPICKUP") then
            game.Workspace.Remote.ItemHandler:InvokeServer(v.ITEMPICKUP)
        end
    end
    
    for i,v in pairs(game.Workspace.Prison_ITEMS.giver:GetChildren()) do
        if v:FindFirstChild("ITEMPICKUP") then
            game.Workspace.Remote.ItemHandler:InvokeServer(v.ITEMPICKUP)
        end
    end
end)

MainCheatsSection:CreateButton("Join/Left Alerts", function()
    getgenv().alerts = state
end)

MainCheatsSection:CreateButton("Remove All Doors", function()
    game.Workspace.Doors:Destroy()
        game.Workspace.Prison_Cellblock.doors:Destroy()
        local Warehouses = game.Workspace.Warehouses
        for i,v in pairs(Warehouses:GetDescendants()) do
            if v.Name == "doors" then
               v:Destroy()
            end
        end
end)

MainCheatsSection:CreateButton("Kill All", function()
    workspace.Remote.TeamEvent:FireServer("Medium stone grey")

    game.Workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP) 
    
    wait(0.5)
    function kill(a)
    local A_1 =
    {
    [1] =
    {
    ["RayObject"] = Ray.new(Vector3.new(845.555908, 101.429337, 2269.43945), Vector3.new(-391.152252, 8.65560055, -83.2166901)),
    ["Distance"] = 3.2524313926697,
    ["Cframe"] = CFrame.new(840.310791, 101.334137, 2267.87988, 0.0636406094, 0.151434347, -0.986416459, 0, 0.988420188, 0.151741937, 0.997972965, -0.00965694897, 0.0629036576),
    ["Hit"] = a.Character.Head
    },
      [2] =
    {
    ["RayObject"] = Ray.new(Vector3.new(845.555908, 101.429337, 2269.43945), Vector3.new(-392.481476, -8.44939327, -76.7261353)),
    ["Distance"] = 3.2699294090271,
    ["Cframe"] = CFrame.new(840.290466, 101.184189, 2267.93506, 0.0964837447, 0.0589403138, -0.993587971, 4.65661287e-10, 0.998245299, 0.0592165813, 0.995334625, -0.00571343815, 0.0963144377),
    ["Hit"] = a.Character.Head
    },
    [3] =
    {
    ["RayObject"] = Ray.new(Vector3.new(845.555908, 101.429337, 2269.43945), Vector3.new(-389.21701, -2.50536323, -92.2163162)),
    ["Distance"] = 3.1665518283844,
    ["Cframe"] = CFrame.new(840.338867, 101.236496, 2267.80371, 0.0166504811, 0.0941716284, -0.995416701, 1.16415322e-10, 0.995554805, 0.0941846818, 0.999861419, -0.00156822044, 0.0165764652),
    ["Hit"] = a.Character.Head
    },
    [4] =
    {
    ["RayObject"] = Ray.new(Vector3.new(845.555908, 101.429337, 2269.43945), Vector3.new(-393.353973, 3.13988972, -72.5452042)),
    ["Distance"] = 3.3218522071838,
    ["Cframe"] = CFrame.new(840.277222, 101.285957, 2267.9707, 0.117109694, 0.118740402, -0.985994935, -1.86264515e-09, 0.992826641, 0.119563118, 0.993119001, -0.0140019981, 0.116269611),
    ["Hit"] = a.Character.Head
    },
    [5] =
    {
    ["RayObject"] = Ray.new(Vector3.new(845.555908, 101.429337, 2269.43945), Vector3.new(-390.73172, 3.2097764, -85.5477524)),
    ["Distance"] = 3.222757101059,
    ["Cframe"] = CFrame.new(840.317993, 101.286423, 2267.86035, 0.0517584644, 0.123365127, -0.991010666, 0, 0.992340803, 0.123530701, 0.99865967, -0.00639375951, 0.0513620302),
    ["Hit"] = a.Character.Head
    }
    }
    local A_2 = game.Players.LocalPlayer.Backpack["Remington 870"]
    local Event = game:GetService("ReplicatedStorage").ShootEvent
    Event:FireServer(A_1, A_2)
    Event:FireServer(A_1, A_2)
    end
    
    for i,v in pairs(game.Players:GetChildren())do
    if v.Name ~= game.Players.LocalPlayer.Name then
    kill(v)
    end
    end
    wait(1)
    workspace.Remote.TeamEvent:FireServer("Bright orange")
end)


MainCheatsSection:CreateDropdown("Switch Teams", {"Cop", "Prisoner", "Criminal", "Neutral"}, 2, function(Team)
    if Team == "Cop" then
        game.Workspace.Remote.TeamEvent:FireServer("Bright blue")
    elseif Team == "Prisoner" then
        game.Workspace.Remote.TeamEvent:FireServer("Bright orange")
    elseif Team == "Criminal" then
        local weld02 = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-919.958, 95.327, 2138.189)
    		wait(1)
    		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(weld02)
        elseif Team == "Neutral" then
            game.Workspace.Remote.TeamEvent:FireServer("Medium stone grey")
    end
end)

MainCheatsSection:CreateButton("Taser Bypass", function(state)
    game.Players.LocalPlayer.Character.ClientInputHandler.Disabled = true
   game.Players.LocalPlayer.CharacterAdded:connect(function()
   game.Workspace:WaitForChild(game.Players.LocalPlayer.Name)
   game.Players.LocalPlayer.Character.ClientInputHandler.Disabled = true
   end)
   

    end)

MainCheatsSection:CreateTextbox("Arrest Player", function(txt)
   
    if txt == "all" then
        for i,v in pairs(game.Teams.Criminals:GetPlayers()) do
            if v ~= game.Players.LocalPlayer then
                i = 0
                repeat wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                    game.Workspace.Remote.arrest:InvokeServer(v.Character.HumanoidRootPart)
                    i = i + 1
                until i == 10
            end
        end
    else
        local plr = findplayer(txt)
        if plr then
            local i = 0
            repeat wait()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
                game.Workspace.Remote.arrest:InvokeServer(plr.Character.HumanoidRootPart)
                i = i + 1
            until i == 10
        end
    end
end)

MainCheatsSection:CreateDropdown("Meele", {"Knife", "Bow Knife", "Hammer", "Bat", "Lightsaber", "Butterfly Knife"}, 5, function(Meele)
    if Meele == "Knife" then
        print'shingg'
    elseif Meele == "Boom" then
        print'owweeee.'
    elseif Meele == "Lightsaber" then
        print'nyaaaa wera wera werrr werrrr.'
    end
end)

--PLAYER
local PlayerWindow = Library:NewWindow("Player")

local PlayerSection = PlayerWindow:NewSection("Player")

PlayerSection:CreateTextbox("Walkspeed", function(Walkspeed)
   
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Walkspeed)
    
end)

if getgenv().changedjumppower then
    game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = getgenv().jumppower
end

PlayerSection:CreateTextbox("Jumpower", function(txt)
   
    getgenv().changedjumppower = true
    if tonumber(txt) then
        getgenv().jumppower = tonumber(txt)
    end
    
end)




PlayerSection:CreateButton("One Punch", function(state)
    getgenv().onepunch = state
    end)
    
    mainRemotes = game.ReplicatedStorage
    meleeRemote = mainRemotes['meleeEvent']
    mouse = game.Players.LocalPlayer:GetMouse()
    punching = false
    cooldown = false
    
    function punch()
    cooldown = true
    local part = Instance.new("Part", game.Players.LocalPlayer.Character)
    part.Transparency = 1
    part.Size = Vector3.new(5, 2, 3)
    part.CanCollide = false
    local w1 = Instance.new("Weld", part)
    w1.Part0 = game.Players.LocalPlayer.Character.Torso
    w1.Part1 = part
    w1.C1 = CFrame.new(0,0,2)
    part.Touched:connect(function(hit)
    if game.Players:FindFirstChild(hit.Parent.Name) then
    local plr = game.Players:FindFirstChild(hit.Parent.Name)
    if plr.Name ~= game.Players.LocalPlayer.Name then
    part:Destroy()
    
    for i = 1,100 do
    meleeRemote:FireServer(plr)
    end
    end
    end
    end)
    
    wait(1)
    cooldown = false
    part:Destroy()
    end
    
    
    mouse.KeyDown:connect(function(key)
    if cooldown == false then
    if key:lower() == "f" then
    
    if getgenv().onepunch then
    punch()
    end
    end
    end
    end)

    PlayerSection:CreateButton("Reset Character", function(state)
        game.Workspace.Remote.loadchar:InvokeServer(game.Players.LocalPlayer.Name)
        end)

   PlayerSection:CreateToggle("Inf Stamina", function(enabled)
        if enabled then 
            local plr = game:GetService("Players").LocalPlayer
            for i,v in next, getgc() do 
                if type(v) == "function" and getfenv(v).script and getfenv(v).script == plr.Character.ClientInputHandler then 
                    for i2,v2 in next, debug.getupvalues(v) do 
                        if type(v2) == "number" then 
                            debug.setupvalue(v, i2, math.huge)
                        end
                    end
                end
            end
        
        
 
        
        
        elseif not enabled then
            local plr = game:GetService("Players").LocalPlayer
            for i,v in next, getgc() do 
                if type(v) == "function" and getfenv(v).script and getfenv(v).script == plr.Character.ClientInputHandler then 
                    for i2,v2 in next, debug.getupvalues(v) do 
                        if type(v2) == "number" then 
                            debug.setupvalue(v, i2, 12)
                        end
                    end
                end

            end

        

        end
    end)

    game:GetService("RunService").RenderStepped:Connect(function()
        if game.Players.LocalPlayer.Character.Humanoid.Health == 0 and getgenv().godmode then
            local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
            game.Workspace.Remote.loadchar:InvokeServer(game.Players.LocalPlayer.Name)  
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
        end
    end)

    PlayerSection:CreateButton("God Mode", function(state)
        getgenv().godmode = state
        end)

        PlayerSection:CreateButton("Bring All", function(state)
            workspace.Remote.TeamEvent:FireServer("Bright blue")

local LocalPlayer = game:GetService("Players").LocalPlayer
local runservice = game:GetService("RunService")
local characters = {}
LocalPlayer.Character:FindFirstChild("Humanoid"):UnequipTools()
local currentamount = #LocalPlayer.Backpack:GetChildren()
LocalPlayer.Character.Archivable = true
local tempchar = LocalPlayer.Character:Clone()
tempchar.Parent = workspace
local savepos = LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
local renderstepped = runservice.RenderStepped:Connect(function()
    workspace.CurrentCamera.CameraSubject = tempchar:FindFirstChild("Humanoid")
    for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
    if tool:IsA("Tool") then
            tool.Parent = LocalPlayer
        end
    end
    LocalPlayer.Character:ClearAllChildren()
    local char = Instance.new("Model", workspace)
    table.insert(characters, char)
    Instance.new("Humanoid", char)
    LocalPlayer.Character = char
    repeat runservice.RenderStepped:Wait() until LocalPlayer.Character ~= nil
end)
repeat runservice.RenderStepped:Wait() until #LocalPlayer:GetChildren() - 2 - currentamount >= #game.Players:GetPlayers() * 6
renderstepped:Disconnect()
repeat runservice.RenderStepped:Wait() until LocalPlayer.Character:FindFirstChild("HumanoidRootPart") ~= nil
for _, char in pairs(characters) do
    char:Destroy()
end
for _, tool in pairs(LocalPlayer:GetChildren()) do
    if tool:IsA("Tool") then
        tool.Parent = LocalPlayer.Backpack
    end
end
LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = savepos
tempchar:Destroy()

wait()

for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(.1)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
for i, v in pairs(game.Players:GetPlayers()) do
if v and v.Name ~= game.Players.LocalPlayer.Name then
  
game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Character
  
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace.Terrain
  wait()
  v.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.rightVector)

end
wait(0.01)

end
            end)

    
        PlayerSection:CreateButton("Invisible", function(state)
            local player = game.Players.LocalPlayer
position     = player.Character.HumanoidRootPart.Position
wait(0.1)
player.Character:MoveTo(position + Vector3.new(0, 1000000, 0))
wait(0.1)
humanoidrootpart = player.Character.HumanoidRootPart:clone()
wait(0.1)
player.Character.HumanoidRootPart:Destroy()
humanoidrootpart.Parent = player.Character
player.Character:MoveTo(position)
wait()
-- Remove this if you want to see yourself (others still won't see you)
game.Players.LocalPlayer.Character.Torso.Transparency = 0.5
game.Players.LocalPlayer.Character.Head.Transparency  = 0.5
game.Players.LocalPlayer.Character["Left Arm"].Transparency = 0.5
game.Players.LocalPlayer.Character["Right Arm"].Transparency = 0.5
game.Players.LocalPlayer.Character["Left Leg"].Transparency = 0.5
game.Players.LocalPlayer.Character["Right Leg"].Transparency = 0.5
game.Players.LocalPlayer.Character.Humanoid:RemoveAccessories()
game.Players.LocalPlayer.Character.Head.face:Remove()

            end)

    PlayerSection:CreateButton("FLIGHT (E)", function()
        repeat wait()
        until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("Torso") and game.Players.LocalPlayer.Character:findFirstChild("Humanoid")
        local mouse = game.Players.LocalPlayer:GetMouse()
        repeat wait() until mouse
        local plr = game.Players.LocalPlayer
        local torso = plr.Character.Torso
        local deb = true
        local ctrl = {f = 0, b = 0, l = 0, r = 0}
        local lastctrl = {f = 0, b = 0, l = 0, r = 0}
        local maxspeed = 70
        local speed = 0
        
        function Fly()
            local bg = Instance.new("BodyGyro", torso)
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = torso.CFrame
            local bv = Instance.new("BodyVelocity", torso)
            bv.velocity = Vector3.new(0,0.1,0)
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            repeat wait()
            plr.Character.Humanoid.PlatformStand = true
            if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
            speed = speed+.5+(speed/maxspeed)
            if speed > maxspeed then
            speed = maxspeed
            end
            elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
            speed = speed-1
            if speed < 0 then
            speed = 0
            end
            end
            if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
            bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
            lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
            elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
            bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
            else
            bv.velocity = Vector3.new(0,0.1,0)
            end
            bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
            until not flying
            ctrl = {f = 0, b = 0, l = 0, r = 0}
            lastctrl = {f = 0, b = 0, l = 0, r = 0}
            speed = 0
            bg:Destroy()
            bv:Destroy()
            plr.Character.Humanoid.PlatformStand = false
            end
            mouse.KeyDown:connect(function(key)
            if key:lower() == "e" then
            if flying then flying = false
            else
            flying = true
            Fly()
            end
            elseif key:lower() == "w" then
            ctrl.f = 1
            elseif key:lower() == "s" then
            ctrl.b = -1
            elseif key:lower() == "a" then
            ctrl.l = -1
            elseif key:lower() == "d" then
            ctrl.r = 1
        end
    end)
        mouse.KeyUp:connect(function(key)
        if key:lower() == "w" then
        ctrl.f = 0
        elseif key:lower() == "s" then
        ctrl.b = 0
        elseif key:lower() == "a" then
        ctrl.l = 0
        elseif key:lower() == "d" then
        ctrl.r = 0
        end
        end)
        Fly()
    

        
        end)


    --TELEPORT

    local TeleportWindow = Library:NewWindow("Teleport")

    local TeleportSection = TeleportWindow:NewSection("Teleport")

    TeleportSection:CreateDropdown("Teleport", {"Criminal Base", "Downtown", "Entrance Gate", "Entrance", "Cafeteria", "Cell Block", "Hallway", "Armory", "Guards Only"}, 2, function(Teleport)
        if Teleport == "Criminal Base" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-859.15161132813, 94.476051330566, 2058.5427246094)
        elseif Teleport == "Downtown" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-300.44033813477, 54.175037384033, 1781.2364501953)
        elseif Teleport == "Entrance Gate" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(491.27182006836, 98.039939880371, 2216.3107910156)
            elseif Teleport == "Entrance" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(653.81713867188, 99.990005493164, 2272.083984375)
            elseif Teleport == "Cafeteria" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(932.06213378906, 99.989959716797, 2290.4250488281)
            elseif Teleport == "Cell Block" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(918.43115234375, 99.989990234375, 2440.3828125)
            elseif Teleport == "Hallway" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(860.78448486328, 99.990005493164, 2362.9597167969)
            elseif Teleport == "Armory" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(835.28918457031, 99.990005493164, 2285.4909667969)
            elseif Teleport == "Guards Only" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(830.04302978516, 99.990005493164, 2327.0859375)
        end
    end)

    TeleportSection:CreateTextbox("Tp To Player", function(Player)
   
        local plr = findplayer(Player)
        if plr then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
    	end
        
    end)

    TeleportSection:CreateTextbox("Bring Player", function(txt)
   
        game.Workspace.Remote.ItemHandler:InvokeServer(game.Workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)
        local Target = findplayer(txt).Name
        if Target then
            NOW = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            game.Players.LocalPlayer.Character.Humanoid.Name = 1
            local l = game.Players.LocalPlayer.Character["1"]:Clone()
            l.Parent = game.Players.LocalPlayer.Character
            l.Name = "Humanoid"
            wait()
            game.Players.LocalPlayer.Character["1"]:Destroy()
            game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
            game.Players.LocalPlayer.Character.Animate.Disabled = true
            wait()
            game.Players.LocalPlayer.Character.Animate.Disabled = false
            game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType = "None"
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack["Remington 870"])
            local function tp(player,player2)
            local char1,char2=player.Character,player2.Character
            if char1 and char2 then
            char1.HumanoidRootPart.CFrame = char2.HumanoidRootPart.CFrame
            end
            end
            local function getout(player,player2)
            local char1,char2=player.Character,player2.Character
            if char1 and char2 then
            char1:MoveTo(char2.Head.Position)
            end
            end
            tp(game.Players[Target], game.Players.LocalPlayer)
            wait()
            tp(game.Players[Target], game.Players.LocalPlayer)
            wait()
            getout(game.Players.LocalPlayer, game.Players[Target])
            wait(5)
            game.Workspace.Remote.loadchar:InvokeServer(game.Players.LocalPlayer.Name)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = NOW
        end
        
    end)

    TeleportSection:CreateButton("Server Hop", function()
        local Servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        for i,v in pairs(Servers.data) do
    		if v.playing ~= v.maxPlayers then
    			game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, v.id)
    		end
    	end
        end)

  TeleportSection:CreateButton("Rejoin", function()
        game:GetService("TeleportService"):Teleport(game.PlaceId)
        end)


       

       
  
            --GUNS

    local GunsWindow = Library:NewWindow("Guns")

    local ModdedSection = GunsWindow:NewSection("ModdedSection")

    ModdedSection:CreateButton("Fast Remington", function()
        local Player = game.Players.LocalPlayer.Name
        local Gun = "Remington 870" -- < -- Gun Name
        local Run = game:GetService("RunService")
        
        Gun = game.Players[Player].Character[Gun]
        local Mouse = game.Players.LocalPlayer:GetMouse()
        local Down = false
        local Sound = Gun.Handle.FireSound
        
        function CreateRay(Point_A, Point_B)
        local Ray = Ray.new(Point_A, (Point_B - Point_A).Unit * (2 ^ 31 - 1))
        local Part, Pos = workspace:FindPartOnRay(Ray, game.Players.LocalPlayer.Character)
        local Dist = (Point_A - Pos).Magnitude
        local CFrame = CFrame.new(Point_A, Pos) * CFrame.new(0, 0, -Dist / 2)
        
        return CFrame, Dist, Ray
        end
        
        function FireLaser(target)
        coroutine.resume(coroutine.create(function()
        local C, D, R = CreateRay(Gun.Muzzle.CFrame.p, target.CFrame.p)
        local Bullet = Instance.new("Part", Gun)
        Bullet.BrickColor = BrickColor.Yellow()
        Bullet.Material = "Neon"
        Bullet.Anchored = true
        Bullet.CanCollide = false
        Bullet.Size = Vector3.new(0.2, 0.2, D)
        Bullet.CFrame = C
        
        local bulletTable = {}
        table.insert(bulletTable, {
        Hit = target,
        Distance = D,
        Cframe = C,
        RayObject = R
        })
        
        game.ReplicatedStorage.ShootEvent:FireServer(bulletTable, Gun)
        local C = Sound:Clone()
        C.Parent = Gun
        C:Play()
        wait(0.05)
        Bullet:Remove()
        end))
        end
        
        Mouse.Button1Down:Connect(function()
        Down = true
        end)
        
        
        Mouse.Button1Up:Connect(function()
        Down = false
        end)
        
        while Run.Stepped:wait() do
        if Down == true then
        game.ReplicatedStorage.SoundEvent:FireServer(Sound, Gun)
        FireLaser(Mouse.Target)
        end
    end
        end)


        ModdedSection:CreateButton("Fast M9", function()
            local Player = game.Players.LocalPlayer.Name
local Gun = "M9" -- < -- Gun Name
local Run = game:GetService("RunService")

Gun = game.Players[Player].Character[Gun]
local Mouse = game.Players.LocalPlayer:GetMouse()
local Down = false
local Sound = Gun.Handle.FireSound

function CreateRay(Point_A, Point_B)
local Ray = Ray.new(Point_A, (Point_B - Point_A).Unit * (2 ^ 31 - 1))
local Part, Pos = workspace:FindPartOnRay(Ray, game.Players.LocalPlayer.Character)
local Dist = (Point_A - Pos).Magnitude
local CFrame = CFrame.new(Point_A, Pos) * CFrame.new(0, 0, -Dist / 2)

return CFrame, Dist, Ray
end

function FireLaser(target)
coroutine.resume(coroutine.create(function()
local C, D, R = CreateRay(Gun.Muzzle.CFrame.p, target.CFrame.p)
local Bullet = Instance.new("Part", Gun)
Bullet.BrickColor = BrickColor.Yellow()
Bullet.Material = "Neon"
Bullet.Anchored = true
Bullet.CanCollide = false
Bullet.Size = Vector3.new(0.2, 0.2, D)
Bullet.CFrame = C

local bulletTable = {}
table.insert(bulletTable, {
Hit = target,
Distance = D,
Cframe = C,
RayObject = R
})

game.ReplicatedStorage.ShootEvent:FireServer(bulletTable, Gun)
local C = Sound:Clone()
C.Parent = Gun
C:Play()
wait(0.05)
Bullet:Remove()
end))
end

Mouse.Button1Down:Connect(function()
Down = true
end)


Mouse.Button1Up:Connect(function()
Down = false
end)

while Run.Stepped:wait() do
if Down == true then
game.ReplicatedStorage.SoundEvent:FireServer(Sound, Gun)
FireLaser(Mouse.Target)
end
end
end)
         

ModdedSection:CreateButton("Fast Taser", function()
    local Player = game.Players.LocalPlayer.Name
    local Gun = "Taser" -- < -- Gun Name
    local Run = game:GetService("RunService")
    
    Gun = game.Players[Player].Character[Gun]
    local Mouse = game.Players.LocalPlayer:GetMouse()
    local Down = false
    local Sound = Gun.Handle.FireSound
    
    function CreateRay(Point_A, Point_B)
    local Ray = Ray.new(Point_A, (Point_B - Point_A).Unit * (2 ^ 31 - 1))
    local Part, Pos = workspace:FindPartOnRay(Ray, game.Players.LocalPlayer.Character)
    local Dist = (Point_A - Pos).Magnitude
    local CFrame = CFrame.new(Point_A, Pos) * CFrame.new(0, 0, -Dist / 2)
    
    return CFrame, Dist, Ray
    end
    
    function FireLaser(target)
    coroutine.resume(coroutine.create(function()
    local C, D, R = CreateRay(Gun.Muzzle.CFrame.p, target.CFrame.p)
    local Bullet = Instance.new("Part", Gun)
    Bullet.BrickColor = BrickColor.Yellow()
    Bullet.Material = "Neon"
    Bullet.Anchored = true
    Bullet.CanCollide = false
    Bullet.Size = Vector3.new(0.2, 0.2, D)
    Bullet.CFrame = C
    
    local bulletTable = {}
    table.insert(bulletTable, {
    Hit = target,
    Distance = D,
    Cframe = C,
    RayObject = R
    })
    
    game.ReplicatedStorage.ShootEvent:FireServer(bulletTable, Gun)
    local C = Sound:Clone()
    C.Parent = Gun
    C:Play()
    wait(0.05)
    Bullet:Remove()
    end))
    end
    
    Mouse.Button1Down:Connect(function()
    Down = true
    end)
    
    
    Mouse.Button1Up:Connect(function()
    Down = false
    end)
    
    while Run.Stepped:wait() do
    if Down == true then
    game.ReplicatedStorage.SoundEvent:FireServer(Sound, Gun)
    FireLaser(Mouse.Target)
    end
    end
    end)  

    ModdedSection:CreateButton("Fast AK47", function()
        local Player = game.Players.LocalPlayer.Name
        local Gun = "AK47" -- < -- Gun Name
        local Run = game:GetService("RunService")
        
        Gun = game.Players[Player].Character[Gun]
        local Mouse = game.Players.LocalPlayer:GetMouse()
        local Down = false
        local Sound = Gun.Handle.FireSound
        
        function CreateRay(Point_A, Point_B)
        local Ray = Ray.new(Point_A, (Point_B - Point_A).Unit * (2 ^ 31 - 1))
        local Part, Pos = workspace:FindPartOnRay(Ray, game.Players.LocalPlayer.Character)
        local Dist = (Point_A - Pos).Magnitude
        local CFrame = CFrame.new(Point_A, Pos) * CFrame.new(0, 0, -Dist / 2)
        
        return CFrame, Dist, Ray
        end
        
        function FireLaser(target)
        coroutine.resume(coroutine.create(function()
        local C, D, R = CreateRay(Gun.Muzzle.CFrame.p, target.CFrame.p)
        local Bullet = Instance.new("Part", Gun)
        Bullet.BrickColor = BrickColor.Yellow()
        Bullet.Material = "Neon"
        Bullet.Anchored = true
        Bullet.CanCollide = false
        Bullet.Size = Vector3.new(0.2, 0.2, D)
        Bullet.CFrame = C
        
        local bulletTable = {}
        table.insert(bulletTable, {
        Hit = target,
        Distance = D,
        Cframe = C,
        RayObject = R
        })
        
        game.ReplicatedStorage.ShootEvent:FireServer(bulletTable, Gun)
        local C = Sound:Clone()
        C.Parent = Gun
        C:Play()
        wait(0.05)
        Bullet:Remove()
        end))
        end
        
        Mouse.Button1Down:Connect(function()
        Down = true
        end)
        
        
        Mouse.Button1Up:Connect(function()
        Down = false
        end)
        
        while Run.Stepped:wait() do
        if Down == true then
        game.ReplicatedStorage.SoundEvent:FireServer(Sound, Gun)
        FireLaser(Mouse.Target)
        end
        end
        end)

        local CreditWindow = Library:NewWindow("Made By Kevinn#2021")

        local OthersSection = CreditWindow:NewSection("Credit To Jake11price And Others")


        game.Players.PlayerAdded:Connect(function(plr)
            if getgenv().alerts then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Player Joined",
                    Text = plr.Name.." has joined the game!",
                    Duration = 5
                })
            end
        end)
        
        game.Players.PlayerRemoved:Connect(function(plr)
            if getgenv().alerts then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Player Left",
                    Text = plr.Name.." has left the game.",
                    Duration = 5
                })
            
            
        end
    end)
