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

local ReachWindow = Library:NewWindow("KN HUB SWORD REACH")

local MainCheatsSection = ReachWindow:NewSection("Reach")

MainCheatsSection:CreateButton("Kill Aura", function()
    --// Setting \\--
local range = ReachRange

--// Variable \\--
local player = game:GetService("Players").LocalPlayer

--// Script \\--
game:GetService("RunService").RenderStepped:Connect(function()
    local p = game.Players:GetPlayers()
    for i = 2, #p do local v = p[i].Character
        if v and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") and player:DistanceFromCharacter(v.HumanoidRootPart.Position) <= range then
            local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
            if tool and tool:FindFirstChild("Handle") then
                tool:Activate()
                for i,v in next, v:GetChildren() do
                    if v:IsA("BasePart") then
                        firetouchinterest(tool.Handle,v,0)
                        firetouchinterest(tool.Handle,v,1)
                    end
                end
            end
        end
    end
end)
end)

ReachRange = "15";

MainCheatsSection:CreateTextbox("Kill Aura Range", function(ReachRange)
   
  ReachRange = (ReachRange)
    
end)*!%{c{*,%cc_*n%cN,-yUc##y3,U3c ?{n-V-^{N,3-,kn,*-{;{#N--UU,:-nd#,U3,g-n#**{pn,?#_#{{*:Uyc#:n?n{y:*%3N{c*?U{N3_u_#-3ny,{n:3y{,_nU*V%{cn*#_WN:*a%cNc:?%U#*:U%Nn--:UyN_:_Un#:-?U##n-yE,c*:UwM{?*:>,,c-Uy%{*-_%N{c3:y-{?3,y*{n3Uy%{#nUUn{*c:?S_{n%?:_:cn*_%:N38a#c-,U##N:_:{,%-UUr,::Ur?#,-N:{}:3#K#,N3n-GU,#n:_Un##-#y?,n3*MU,,--%y,R3{y_ny-UlU,%3yyy{*3#yy{:3,yc{ynQ%%c,*%U-cQ:n%_N#c{*?_%c#*,N%-nU:NU:%U%__-UO?,cNU:{Un:U:_%_Nc::UnN,:nU:#-:%gn,*?,Un,c3:o?#_-nbn,*-,LN,:-Uy,{n3y%_{{ncyc,23Uy{{,3my{{_nn?,%ycc*#N{:-U_#,:{::#,:%K-#?:nU{#:-,4y#%3NhN,,-*-c%n#dy,{B3#*n_,3N*n{n3,yU%*Nny_{#c_?3%NnUy_y%{*3Uy,N*-Uyp{{nc?Nn_nyy#{{3_y,{Nn:y_{,n%?n{_c{U#Nn:#gyN{-*UN#3Nc*%%#N3:n##3*U)#,-#j#f:N{:#U{Nd:,U-N_yU{?nc-US{,n5U7_#4-_QN,U3,yn,y*_y_N%*:_:c 3nU3nU?U_3_-:,yn_cc:?P{{nn?U%-c{*%,{-*U?N{-::c#:-:Jn,n-y6,U{3:wnUe-Uy*W:3n-{,#3Uy,{c,cyy{y3U?*{-n??nyc3Q?yy{n:**_:cync{6cyn{_Ucnn&_NcNc:%:c_*#%UN:***3_,cn**_UnNM-%:cJ:yN-c-**%?c-::,?:Ub?,N-:p,,y-%:>U3#?:%UU3?y,,c3*y?{?,{-*)y#,-8g:,?-%gG,n-UMn,233z{,%3y%*c3*{?*{>n,_*_ynyyL{_n:?3_?n#?-_yc,*n#Un,*{%%-X*n%:cn:#%UcNy-U:Nf*_%_N-:nUyN{:#%UNU-*bN#e3?{?n*?y{U3%?*_*n33P_#cn?c_:nNn3y,{nn*%,,nnc?:{nnyyn{nn:y%{%nc?n_,cn?y#_c{?%_nc??%_{cN*?%yNnxU_,N{:c,3-*s3,_-cTU,-3?-:,{#cyyU&n*-c{?,*?*_Nn??UU,,{?yy:,p3{_:{*3,y{{c3Ny*{y3cy-{?nn?__:c3__Ny*%U*%::*%_N3:U*/,Un*yn{,N{:c#y:{U##U-3;NU{33U,U.#Nh%{*3UyN,_#::bU{#n3?In,*-U&,,*3:l?#%-n}c,:-Uyn,m3Sy*,_33y*,_3#?*{Un,?*_:nb*yc-n*?n_?n-?N{4n,?-_-c*?,_-c-**%:c-%U%_cU*N%#cU*%%N#*:U%N-%yn,:-Uz%,%#myU_-3%?,O,#-?n{#nC3ny*#_?_B{N_?:_-,*n:yz,{3,yc,D3<y#{:ncy{_nc*y_#Nc%y-,#:yr,_#N3Sn_*N:*W%*cU*n%UN,*-{y#3U_%vcNy?__-_^_,yN_:_4#n,:nhc,:-Eyy3--#b-#x--8:,3-L0-,n3*6U,-3-y?,%3-{U{_3_y%{:n?y}{nnn?c_,cn**{_-N*c_#cy?__cc,*n_,c,**%U3n**U:Nw:{%,N{:nU:#*-NU1,?y?{*nyy_{U,{y#,U3{yNy3,,3ny*,U-N%-{:3(?yn-3cy:{:3-y3{?3{y-nUn_y7{Nn*?:{<n_?{{UnU*n%*-,?n%cN:*B%*cn*N%-c_*W%-N:*{U*#N:Q=?-kjN,*,:yn,N,c4A{cnn3c_?n,yN{:{*30_*{cyD_cc*?#_N{%n*yU{,nnyyN_n{?c_N?_yU{{nNy_{_n_?#{_c{U#Nn:#LyN{-*UN#3Nc*%%#N3:n##3*U9#,-#e#j:NU:#U*#c:cUc#c:N{,3%?:S,,c3*,,,N-nk*#U3?WU,*3?y*,{n*yUNn3*?:{(*%_,c%:-_KNn*_%#_{:y?EN#ccU:_T-**,#:3yB*,nc*::%Q-3:c#%N4O-U:#:*&%_N%:{%U#?-n4*#{-{U{#--*Ug#N3*YU,,3*y:,v-%X_,*3cyy,_3U?-{{n%Ucc)*U_%Nncc__N,c{UyN-c%**_Uc,*n_Ucj*{_{c:?U%ycU*UU-N{:%,?-NZU,%3*y:,U3?-{,-33yn{3n?3:{-n*?:{y,%3*rU,,--{#c*yA{,n#?#y{c::y%*NnnnyyN**3%{_*nUyN#-c:?i%y*-_U__c*?#_:c3?%_Nc:?O_,Nn:*,,cn:cU:cU*{%_N:::%wNn::Un#,-nUyn_-{Tc#--:U%#n-# n,?-LW#,,nyyc{#?__%c_n{_NN?*#_nc-:y%Ucc*N%?_B*N%^N,*{%ccUN:U:N_:{:?%nN**U,nc*::U33c*U%{c;-?UnNy?U{vnA*n,_-_:*z:#J-{UU#*-,yy,c3#U:Nn3F{Uc*n:yUn_*3_%n,?N%-N*?{%n_3n,?n_*nUyN#-c:yq{%nN?#_-n_?c_*c3*,,*nU*p%{cn*{%UN,*-{yNP*%%_Nn:c%_N_:cU3#*-n{UN,-{xc#--U0,#-*y0v,?-%f{,-3:bU,:3?o,{n*UZ,{{ncy*,Un:y%{:n*?*{_n{?U_,n-ey_Pc{*_NynU?,_Ucy*:%yc{*y%?cU*,%yN>Z%#,-%y-#^3nm_,##{-?U%##-,,%nny:,U3%y%yc#{-c9{,{-%;%,33{y3{?3%5_cU*?%c{Un{y_{Nn:?c{Nn,?n_,***y_*n,?%_Nn}*:_{c3*?%,NnXU_,N{:%,7Nn:*%c##:U%Nn--:%U#*:%U-NU:{U{#c-3R,c*:U>k,{3cyN3_-_A,,:-_i%,U3cP_nnn-yc,Un*yU{nn3?y{Unn?U_,cn?y#_c{*c%N*_?%__c-?_%ycU*3__:n:-%cNc*U%#NN:y%{N{:,UU#,?*%U#v-{fc#n-*}:##--=c#_-%V{,,nyyc{#:P_Uc:?J_N_?nn?*{Un,y-#ynZ?{{#n-?-{UnU?3_nn_?{_UN-*{%%:-jn#,:{:{,-3*e?U{-ySUUM3,y-#o-,y,,{3cAnj{nnyl{{,{y,{Un*?nycnyy{{#nU?3_NnNn3y,{nn*%,,nnc?:N??U%?NN*:%,Ny*%?vN-c:Un_{:c*:N%cUUc,-:%=,_n-,::,*N{+,U:3*:{,yN8:wUyNU:,U3N%:{;*#U-cOc,::xO*##-cUC,y3*yN,xn?%_cy?U_e{%n*yU{,nny6{W3Zy,{*n?y{{,c*?U_ccc*:%-*N?%_3cy?N_Nc{*-_Nc,*:%-cN:c,3-*h3,_-ctU,-3?-:U##3-?C*33yU,{3ny3{3,1-3)3#,--_nn#?!yn{:3U{n{-3-y3,{3lyn{?n,?n_*3_%?N,*c%*N?:?*:N{-NU?#UcU?N#,:%^:%,Nn*y,_N{:cUN:_:y%cNN*_%{N_:n%_#*:NU#N_-yUc#::_d{n#yn{#cyy{_*nN?3yc,%3#y3{n?#%*n6?,_#c#c:y%{Nn:?c{cn,?*_cnn?#_:cc?__-nU?N#,:%8:%,Nc:*N,NN*U%:N?*{%{N#:*U?N%-*UUnn:*w:#<-yU#,*-UUNc-3:kn#,-_l-,3-{D#,*3ny,N*-Uy1_?::y*,Mc??n{y:_*?cU-N%NNn3{y:%3-n?*%:N3oc_{c,:3%,c-yy%EN{*_%*N:*_%,N,:3%aNc:U/-#{-%,{n*y?,{n:339,,n3*_,#n3cy#c{-Ubc{#3UmNN-n:VR{:3Nyc,gn:yU{*ny?,#*3U?1_{cc?n_?ne**%Ncm:?#{:_U#NJN^Un#--U:m,-3*Ua,#3nP##%#Wy*,:3y-S{,,cz%{n3#y*{y,%3*QU,,3ney3,3,y:,%3#y3{nyUyUc6*y?{c3*U_{cn*3%3_Q:n*cNU:?Uc{_" local d=(#G+(165));local a,u=({}),({});for e=f,d-x do local n=O(e);a[e]=n;u[e]=n;u[n]=e;end;local i,o=(function(l)local e,o,f=E(l,o,(3));if((e+o+f)~=(248))then n=n+((#{271;(function(...)return 194,506,634,241;end)()}+233));d=d+((#{}+132));end;l=s(l,((#{614;429;730;98;(function(...)return 740,...;end)(835,894,721)}-3)));local n,o,f=(""),(""),({});local e=x;local function c()local n=B(s(l,e,e),(36));e=e+x;local l=B(s(l,e,e+n-x),(36));e=e+n;return(l);end;n=u[c()];f[x]=n;while(e<#l)do local e=c();if a[e]then o=a[e];else o=n..s(n,x,x);end;a[d]=n..s(o,x,x);f[#f+x],n,d=o,o,d+x;end;return(h(f));end)("PSU|22m21H21h26H26h10101T1r1627922821d1j1n1B1Q21f2211e27922a21J18121R1H1Z21f1R1D1N1T161125025z1d27921u217171a15131E191W21F1j27J21Y21G27d1021v1Y1c181n1j23Y26G1727922x1718171c101223621I2172791w21X22g1D220220101B2271l28C1922321z171T1m1n1622k22621p22Z29C1123023521W171o141Q1T1J1816171922727926q25Y2911022X1q21821F21f21o1f131s2a71N2311d1527922b21n1127C152391427922c21n101326i2491V2792341J1f1B182181228E21721b1E1421921a1y1M1I21e21N1f1w21R1F21f21B21k1X2161r1C2341G285102391r1u1227b1H161n21721k1I1S22J21I2B11023028C151z21U2aT102av28v1r21y21L1B27922e21r27C111K1d21L21229O24D26h28L22R1h1N141l1h2311B1327922121M21e2211627N10236171r21d2181m161M171N21m21F1P1K21p22J28V1023729O141V1a162722421927921T1Y102E2101s1T1B21Q21S2ec2361N1K141g2e321F2242D11022421l1K21E21I1h27A2A81K24c26J2cn22U1F1R1N25B2662Cn2382A71G25x2572F72DF1J1i1r1r2EF27H2DC28L22p18141f1D1R21f2251A27922v121h1Q1B1427h2e326n2452Du27p1B1a111N1X2fD2fF191k1223a2eC21x2172Am28D1123v26i2cU22C21d141c1u24P2672cu22S112E41I2702472ae2ee1h1p181H1L2Hx29i25X24J1j2GG2GI2172171s1Q2dH1521N21I1D1127j1t1T1D21Q21v2FR1d191l1k23G2C722821r2a71Q171W21i2dh2eh161Y21t28L2362bc1a1b1224o24622B2792eZ1h2hm1s22621Y1j27X27Z28121y22222622722723721j2iM2b52151Z2em131O21121J1j27h1129o22M1c22f1V2IN17161522k1c2202A02a22a42A62a822621X131c121D22421w22022129a29V1t1S2kw2ie192141q2jd1n2JF172jH2ka2kC2kE22G29S29U22029W2382F61A25W254182792242111e1F2ET2a823e2iv27922321a1S21M2181B1123c1P2fR1t1a2bf2232Hr1i28R1c29M171l2gA2J121Y112792132712652ec22E21f2cF1R1T21S23m2582Ae22C1z1I29e21P2Iy2Eg2eI24G25O2EM1022p1K2ax1s1r2CX23g102Lp102Gh2FE1h2hf2Cb2382Cu22t1n27A1t21A22H2HC2122a5152522hJ2En21e101m1H21422E2gf1022a2131r2n72Iz2EI23u26o2B91022921j21E1w2112141l21n21B21d1X21r21q2GU21H101r21A1z21221F2101421E1721J21a21921621q22x1o1g27922D2dA1N21n2131U15112132N82J025x2532Ec2hd1T1C21i2191n25925D2CN2h51r1o23M26b2ae22r1b1D1627r1F172AS1v1J23c1o2cU2222111d2172191l23F2of2fl2fN1M1Q28D2ga2351u2DN102321B1I21c2272NN22021p1O1c1f11161D2ln2nN21y21b152L42141m1r1p2R12Lq1Z1821G2PY2eI21l2o12au21N2Jv2262EP2791023K26d21126323W2NX1021y1Z112gV1J1d2IB1i21n2q71n2102p5161R1b1N111H23U26K2rB22V181B21k22d2nD22A21N2lt1s21F21H2RZ24q2ad2792251y1b2hT1921i21C1h2rz1424u2o7102341h181R1124c26F2Nn21z1Y1a122HV161B22321H2eC21Z21H27h1v2iH24J2612rB2371a1n21E2S9102df1b191421Y21m2NN22u2Jk27Y2801126g23y2nN21U1Z2ue27t2UE23O28u27922p1F2A3182g823M2U92862N41m21h27G1622X131u2972242Kq2ks22422222f1u21S22g2241v112rv21X22022c22E21T1r29V1h21w29f2RK2cu2tQ1Q2E223u2692Du2rt2891Y21B2u62pF2172WE182ha2cu21w1X162KS24p25K2c72311c1a1e21M214152mX29H28D1y2IK2792QI191j26h24e2CU22u1A2dn1t26h2491227922N1O24d2MS27921V2172In102Jf2732XX2bA1J2Ks1022s1p2Fe2OG21J1l1S152uD2DJ1121j2oI2A42XB26B2452i22dV2Dx2dz2E12E32E521l2v72JM2Va23z2ND2eo27Z1V1N2yW23d2T12792x913171k1p1O21J2yd1L2132161A172U421a2zW21d28G27j1721g2Ex27O2Mv132dM2YM1C2cN23B1m181t2142252YP2wS2E221321j2mO2U622N2362ru2Mb21J2oE2xS2Qj2QL122Rn161O25l250310H1m1j1S2502UR27921y191p22S21K2OF2Ub1H2pX2Ol1622F2d02ba2cc27T2Cf2Ch2cj2612592C72262171H2k01t1p2122181j1P1E1n21A2Eb2I32ce27i1O22Z1c2YP2R329p1F2yu182RN1h312I2mX26H2hq2AU21o1q1R1A21J2s61621L22i28L2x9171g1R1q26g23U2yP22B21e1o21g2rx101I2XB21j21J2F12f3171523e2F72Ee2E22e421m21o2yl26V2El27e21o1d1O1S1n21h21E1S24s25w2yp2nP1s112852Ie2CB1T1v1l29p1D2232V42792392e21N1M152hX24K25f28L228314731491n23e2dt279311n21c1x1M1g2uG28A2vn1724C26C2F72q31C311P2N92J12F627o27Q27S1H28f28H1q22x2M82GG1628p313728L2202191431481s24Y25V2nD22b2TW2NX1B215314D2381N2oF22N102171r1s2kd2NJ1924i25Q2f7311n2zv2X529O1b1V313w2s22kR1d21o3156314a25E2512xy2QO1v1m3166279237316U2a821N2292C722Q2yx1J1w2f01I1322d2ig1723f2te2yb2yd2K4122L8314b21W2rb22T1M1325125E2Ec2np317w1B1O2492DD314v2cA1h2UE24u2NC27923B1I31011s28P1E1H24b2VK2cV2132hw101L1125A25S2of2aG2Pn2am2Ao2e425B311F2u21S1u2332rA28w171q25g24h2yp2HS314J314l1b314n314P314R246318m28M21813131t21T21U23H2aE21Z21228P21i2gy1t2fg26T23T1F312h161j2r52HV2hx2xo1924g25m31Al102Hd192iN2Uo16315Q2j022F21O2dU2xT1f19121g152cF1D1P2F3315l2F72241z317821R2Tw2tY24b26M2mo102uU1d2PN2uy12122qj21M21I2A01N2aS2as2DJ2j231672151f2mb31At318F31831931B91231982fq27922621b28p25X317e2d22ju31BG26B2ZF27922f2Ic1721k1z1l101123D2qt2B22N429E23L2vs10238316S317M1925925u2NN314w29O2rp2IN231122oF2rT2FN31aF2dh27H26S23K28l313Y1h2dx26g23s2dU2NP1n1C2mo1B2cf2V91t23F112Nd2202132b9314q21C28824R2651O2AU21m141o1p1D1l2v921o21F151D2AO21R31Bl2Ks1921821926A31aK315U2ys2yU122yw2X02x221f2Xr102xg2YS22o2nm317k2ob2gz1K25231Ce31A31T1n1Y314D21A22D2n52Cv311L2DJ2qO1e31ao21G31471l1I19314O26u24D28l31AC28P31f62RR2dO21331Ah2Mk2qk25x25a2du22621N1O2qn2gW21i313S3112272313g2792352F21G1g21M21C1121d312431aZ1L31b131912ey2F0142Ni31fw22C2z42hS2i52i72I92iB2id2IF2ih25L31212xS31BY31C02Q72ys1D12313631382Xs31E731i31L2iq2cu2np1j1425525t2f731gt31gv2E428f31CH2eK2nD23b1O31271O13318p1626b23n2CU23427S319p25g2Fw2Au2132t12a821d31cs1G22f2uj2gg2Tb31bA2m525B2U127f315J21b31I628m1521G1J28P1k23D2nN2xT1l1731IU1C26j23l2eC2aG21821P31011L1g23C31Ip2xm1t3125312q1927231gF2xS1H2v0141R24Q2Qa31Cf1L25G25228L2NP2CF1223S319231ID31bz1o24s2YA103155316B2T424c26831aw23b31KC1h3141312q1p1I1d31g61m21k22F2f721u21C2dh1a1x2112Iu31082Rh2862191B1T21q21Q31M022v310E2OG21f1o24J319a27931DO2qj1F1V1U2g01T21b2Ux28J31jR1823C1J2Du31LP1R312S21P2da182K121F2ih26R31k22B221d2nx2a51723l315M31Gl2Pu112sW312s2cF24u31DI31N331HD31b121423G1w2792cP317822421y22j21Y2Eq22922f1631nw27d312531NQ21z22i1g1t29v1A23b2242sf1021s2672671s31101021z314d31c1311q27224F2Cn22Q2851324z26731oB2SF23Q2Vc31gl1Q1y31JA2311U1M31kJ2DH2DJ2m32z831402zb2jl2V922H21J31ov26O25r21J310D31Fo312i14152m531fD2Yn2CN22d1H31692162262ND2hl31642cC1P2RV1K23I31aW21521s22C22n22121U22121X2gT21w31QF1a22n27231532792322Qd31gw31Fz2Nd2N32n51b213213181922l31jd102mU2mW31A72332282ae22W28v316a2Zc2v922U2hF31Gl31ES141e31dT2GM1n25e24G31Bw2rT151O2dg316v1y2H629I1126a31IY2PO31Pv14316p21J2CU23831as26d1o24829722U22J21c23c21c21f22l22j22N22W22T23023023321y31sN31SP23b22A22t23a22t23623731sY21422r21822w21821422U23923222r23822x23323221421522w21P22S21722W21N23622t2382392362321W22W21931SF21C21D1W22t23222s21531TG21522L21p31t731t931tb31tD31tF21522V21p22V21731tx21d31Tn31TP31tR31tt22V31U031U231U421522x22U1w31Uf21P31tX31uv23831SM31UO21p31qW22T31UY31sG21C21c21N22Q31To22p22z31Uq22s31vg21n1W262316E2d21411313524G25X31BW2Rj2Rl31151d21i21P2p62102vX24x25P2nN31e51H2L01025F311931cW21E19182732462C72361H31E72l0132in31j11q23G310G27E21d2yS26R31451021U31LZ1t21R21531kD162Ip2C721v31c21027i1Q21j28o28Q1j26y31oO2Au2cM31kr2552ND31K4314231BZ2Id23021821031NO2w42kt22022D29B2li1a22f31xW22422131qA22H2WC2We1921x22C2Ft21X2Wo26s312Y2aF2ah317A2Al2AN2ap24G31FT22I21H31141b1c1m24P31MB2CO2cq1N31dF26931S02ed31IU1M1p22U31Ez2792Qv31Lv2iX311q24g25I2uS2cf25u256319b1q1v1f319e2ap23W23K22x31sC31Se31Sg21e31sj22t31U731sl31Ss31Sq320331Su31sW31Sy31t023631t231T431t631t831TA31tc31Te31Tg31ti31TK31tm31tO31tq31tS31tu31tW31sG31Tz31u131u331U531v622t31ui320R21n31uU31U021131tX21e21p31V731v91w31v131U11w23q25n22527922U29T29c132321632162lH12233162lH31fJ1021e1T22a1G29c101p131Q2L21R132lG321J321L321n29C321P321R29V230321u321W321y29d1p1221u21S1c1l2L2322024y31Ki2Af29M31dL1N317r31d331BS2Sf313U2y531oB2mB131125C25C27921e21F131221921927921O21q111322h22H323a21C1614244244323o313u24u24u323o141622W22W323O151724j24j323o2mb1V2Op21e21c2v02K4323O181A22p22P323o191B31H6323o1E1C23u23u323O2gA24G24g323O1C1e265265323O1D1f24i24I323O1i1G251251323O1j1H22F22f323o1g1i24w24w323o1h1j23h23H323O1M1k1A2OF324c2zK25H25H323o1K1M21z21Z323o314q21Y31nu321U21c1q1O324f326a2rz22v22V323O1o1q243243323o1p1R25r25R323O1U1S31QW323O2Uo22d22d323O319k26a26A323O314O24O24O323o1y1w22M22M323o1Z1X234234323O1w1Y22o31Fm326A1x1Z24l24l323O21221024y24Y323o21321122r22R323o21021224Z24z323O21131gm1t323O21621424H24H323O21721521u21U323o21421623S23s323O215217238238323O21a218231231323o21B219321Z326A21821a24A24A323O21921b23o23O323O324C1Q2l6326a21f21D23B23b323O21c21e26c26C323O3105312U323o21i21g31zP323a323c1221G21g2sq329K323K31OB324C323q23X23x323u1521D21D323y1623i23i32431722j22J32481823W23w323O2V0226226324G1A258258324L1B211211324p1c2G1324u1D245245324Y1e21K21k32531f24N24n32582f331p5326a325e23a23a325I1i241241325N1j25U25u325s1k249249323O2zK1Y2sE324c326222a22a32662E521M323O326C23d23D323o2rZ21r21r326J1q239239326o1R23k23k326T311d250326X1t31so32711u23z23Z32751V27532791W212212327e1X22B2jC326a327k252252323O327p235235327T21022C22C327Y21123323332832122sQ328821323P23P328c214228228328H21525J25j328M2161x1x328R21726b26B328W21825w25w329121922i22I323o3296247247329A21b22y22Y329F21c23m23m323o329K3268329o21E268268329T21f24D24d329W21g313q32a0323D32a331By32a6132vP323O323Q1I31g1324C313U21T21T32ah25z25Z32Al25x25X32AP25D25d32at1924B24B32AX31bY32B12hX32B526226232b824x24x32Bc22X31ZU326A325422Q22q32BK21w21W325d1h23223232Br317a32Bv21a21A32Bz1K1k32c31L2AJ32611m22s22s32CB21B21b32Ce31iT2Rb324c2Rz26326332cm22N316P326a326p26126132Cu25925932Cx25625632d032A332d423623632d725q25q32Db22U22u327j1y22e22e32dj1z24831SB326A327u25L25l32DR21421432dV2I532DY22T22t32e21S1s32e624024032EA22322332Ee26426432EI2jr32Em24E24e32eQ21A21L21L32eU25425432eY25o25O32F221d23N23n32f524s24s32F925p25p32Fd21621632fg32A221g31A532fk25K25K32fn1425T25t32Ad24m24M32AH24f24f32AL23V23v32Ap21x21X32G424624632ax172Ec324C324m24r24R32B5225321f326A2Ga25G25G32BC24P24p32BG23y23Y32BK1D2C7324c325E22k22K32bR22g22G32Bv21n2b4326A325t23Q23q32h425a25a32h722Z22Z32cb329M32HE23l23l32cI1p25n25N32cm25E25e32Cq25325332CU22122132cx24C24c32d025s25s32d41c2ae324C327A321632Db31v932I922L22l32id1E2du324C327U21s21s32Dr25725732DV31aF32dy323F32e21P1P32e625y25y32eA21821832EE24T24T32ei23r23r32eM25525532jA142cn324C329B24q24Q32eY1o31eO329j21d23E23E32f51N2sM324C310522222232FD24224232Jx32a332NQ32fK1W31Nn321U32a131a5151521f21e122Rb2793236323Q25I25I32A031Po32dx32201r323Z32oV323A24X23R1426e26E2791t25M32FX2922MB32Bx27921g21h31we2vP26G26G21m21n31qy31a5279326P324h23C23C32B132bt32ph21I324Q32C132ph21H1D32Mj1C32c521M21K2gA32p332oJ1F1e32g92oA31c4324Z2dU2io32q531BY32MJ1G1H2J731Ob324q324q21521532A02Gt325V32MJ21i21j31WE325V2791y24H32p632FW2791V26W26f27931I41432pg1032Pi1532nQ1424K24K32Po31PO32Pr32p0323z23T23T32A032Rk1628L1y1z32rk32Om323h21q313u327732ah26026032aL24V24V32Ap327C32g432gz32RW1431AZ32A521E31po32nq32S4323Z326Z32Al328F32aP26926932g423g2nl32Oj31Po32sk11329K323z23F23f32q32Kd31Ob21J21H324432Jp32ph24W23N172722722792sq21326227132oS2dN27132TP31D313324421V21v32Q331WE32so32201O2a727931Az2102132DN21332dw31D31032Q532ry1B324N24423s315P32ub32re2kE2MO12324Q32Tx32q31c2as2cU2zT32Q527932mu32U72dn2122132Mo2Mo32qP32ry31h61G2442451h32V232302Ue2m531d332V61632v8325o313O2Ug32uh32vb2lt2mO32fp21k21h31e72B52dn32Q532v41032qP31Ob328n325j1u2W132RI21H1i2Z432Os31Fd32h3322Z32tV1J319731bS2Sq32Ne312u112IO2372372HX219312a1I32h2279314q325O32SR32w72io32V731h61h1K31Ga31g12ZT32w932GB101Y24M32vb313d32VE1o2U632VW10313132vz32W932Uf324N2hW32wd27921421a32wg32qG31BY32ne32Wu2K42Hm32vn2Hx324M2zk32wy32Pi314Y32X132qP32X431OB1k32ix1k21021132VE1X1y2mo32PR1Z32YJ32UC2Kd32ug2k431wE32w12sf1S24832Uj31QY32Uo121W1732ub23O32TH32OQ32YZ1w1821532UO32Tw32tY32W731We32s332U232U41032U632U81021p21o32Vz32UE32vN32v932uJ32ZN32vE21821B32UO324Q26D26d32Tf32uJ21D31h9322z2131N21D32ZY1c32rY32pZ2Ga23J23j32TF23T1d32PI32v42PW2fB32uO2GA31OE32q332Qe32mj32PS1O2Lt32xn32QP32qe32QS324S1E21O21P330L31eH21L32V432QE32L8330U330W32zR1H330Z2sf1E331132Zu33062oJ32YK2dn331332v423P32Th31F632z71u21R32zb1732sv32tF32th21T21S331522v21T331W32uG32pZ2Mb21E2O932ri21i2V025F25F32qx2of32os31eZ2dM2Rb32xw21831az31bT2EI1A310G2cn31a532NE32r4332p2Vp1132UT32KO330U32qe333232p032541Z1Z32Bk25b25b32GS26626632bR25v25V32bV22431OA32Lk1k32p832h432ZG32c71m26F32rD326a314Q25m25M32hE21031Xu32Oj2lT31ZP32NX32r1331F32uy31zp2du27932TB325431M232bK332p332c325E32lv32w732Qp312U329R32q9325J32rh32pI2fZ32FP32RN32q9325o334J32PI32w92K422922932Po32qE326e21621732ut31ob1u1O181e32zG32WJ21832mJ112Lt332732u232Ut329z32xA2Sp31ov31B928L292323327932U132oz323127D32301021b32h03360211210336010335N32Re31cI31Bs32G62SF330C322Z31OV2KD330L32xR32zA31OV3259335u32A0336732YM33673369335T31Ob3335335x279336i336G1031TG336732W9336j31xa1m33672GT33673365336s31Aw32tu31bY3233330Q31ob31pi25532ln27932Fm3370323123N329E336w2We17323332Vz2sF314y322z31BS313132UC2SF32w9337z279337Y3360336r335q337d314K32Qj27932Bp31Ov31Oc25n32KG31Ob21022s24f31ou31Ob1G22823U333Y31ob21222u338I31OV1w22O1X324k31oB1O22G1S2UX31J02nJ1Q23K26S31Ov1k22c338S31OV182201s31Ln2792hl2hN21z21w31501l22j22432bq337I25r221339v2Sf1y22q25i26d32821022D2Bt29i31Yc1r22731QF2802e431yC1S1D21x221319p318P1l2MX1d22h2271921Y22C33AH21x21V1c2m52211C2211f21Y22h2r522d33AU2hM1522333B81q22b22F2bq22b32fT2252A22mj2XI33b033ax111q1l318622c234131623921W1132yR13319Z1123R339C31Ob1s22k22w32iN337o336y335z31ob1n243329E32W532tL1121k21N2Rb330l31BS33CF23P1133cI332Q2At2cU32V432Qg33872Sq2Vp32pO323d33CY318c337F32oM32Po32OQ33d432Oq31a531BY32po32rk33D432RK32u132rp1533D431po32om32l832PO2kd33D42Kd32ry32nQ32po2a733D42A732ko31A532Po31We33d432PK2tb1b32po31Qy33D431Qy31Az32kO32pO2GT33d432QY325v1A32Po2J733d42j732ug2sQ32po337z32UG32r133822791z1w32u921332tL31A52rO28l2s5292330t32oj33Et10326232ot33f221I292334g323B32oq33Ce314z2CN330U32oY33Cp31p52WE2cU32s0337c31OB32qg335V2cn336X10336z33fH336q32YN31Ob3369"),(#G-(90));local function x(e,n,...)if(e==563989959)then return((l((l((n)-353109,735218))-546974,11975))-988406);elseif(e==169342122)then return((((l((n)-131561,705544))-878757)-134283)-868791);elseif(e==275017953)then return(l(l((l((n)-844447,798348))-145820,61534),493302));elseif(e==887206689)then return(((l(l(n,279733),627457))-613342)-189383);elseif(e==28023000)then return((l(((l(n,677390))-524740)-548046,713855))-37205);elseif(e==314276032)then return((l(l(l((n)-713525,458823),886434),490907))-19102);elseif(e==2375633)then return((l(l(l(n,293035),696211),454838))-406595);elseif(e==726659404)then return(l(l(l(n,879576),6728),434468));elseif(e==269494048)then return((l(l(l(n,388789),329608),896026))-711694);elseif(e==606763780)then return(l(l(l(l(n,642695),346241),509359),619272));else end;end;if _ENV then _ENV._ENV=_ENV end;local B=e[((#{588;(function(...)return;end)()}+738307243))];local b=e[((#{757;896;169;152;(function(...)return 94;end)()}+994131580))];local f=e[((416157163-#("fuck strawberry")))];local a=e[((#{851;(function(...)return 538,398;end)()}+510717752))];local x=e[(447187598)];local h=e[((#{673;}+54070211))];local d=e[(494569399)];local A=e[((#{669;(function(...)return 719,851;end)()}+552154718))];local function c()local e=l(E(i,o,o),n);n=e%x;o=(o+d);return(e);end;local function t(l,e,n)if(n)then local e=(l/h^(e-d))%h^((n-d)-(e-d)+d);return(e-(e%d));else local e=h^(e-d);return(((l%(e+e)>=e)and(d))or(a));end;end;local function a()local a,f,d,e=E(i,o,o+f);a=l(a,n);n=a%x;f=l(f,n);n=f%x;d=l(d,n);n=d%x;e=l(e,n);n=e%x;o=o+b;return((e*A)+(d*B)+(f*x)+a);end;local function f()local d,e=E(i,o,o+h);d=l(d,n);n=d%x;e=l(e,n);n=e%x;o=o+h;return((e*x)+d);end;local p="\35";local function y(...)return({...}),T(p,...);end;local function N(...)local P=e[(927578274)];local N=e[(817819453)];local Q=e[((#{718;440;(function(...)return 878;end)()}+334208170))];local _=e[(927576280)];local T=e['qJ1JB'];local S=e[(460889766)];local D=e[(94049982)];local C=e[(994131585)];local A=e[((#{544;}+54070211))];local h=e[((#{148;(function(...)return 310;end)()}+627631101))];local y=e[((447187621-#("AuthenticTimes was here")))];local U=e["YHE9cGc"];local F=e[(640134308)];local B=e["N3UykZP5"];local x=e[(494569399)];local w=e[(429441679)];local I=e[(909172886)];local b=e[(315869771)];local V=e[(304410726)];local Y=e['Feg1yHye'];local d=e[((#{766;611;(function(...)return 104;end)()}+510717752))];local L=e["QI7tG"];local p=e[(416157148)];local O=e[(242888598)];local X=e[(594621793)];local function m(...)local e=({});local r=({});local k=({});local M=c(n);local G=f(n);for f=d,a(n)-x,x do local r=c(n);if(r%h==C)then local n=c(n);e[f]=(n~=d);elseif(r%h==A)then while(true)do local n=a(n);e[f]=s(i,o,o+n-x);o=o+n;break;end;elseif(r%h==_)then while(true)do local l=a(n);local n=a(n);local a=x;local o=(t(n,x,L)*(A^b))+l;local l=t(n,h,T);local n=((-x)^t(n,b));if(l==d)then if(o==d)then e[f]=g(n*d);break;else l=x;a=d;end;elseif(l==N)then e[f]=(o==d)and(n*(x/d))or(n*(d/d));break;end;local n=ee(n,l-Y)*(a+(o/(A^S)));e[f]=n%x==d and g(n)or n break;end;elseif(r%h==B)then while(true)do local a=a(n);if(a==d)then e[f]=('');break;end;if(a>P)then local d,c=(''),(s(i,o,o+a-x));o=o+a;for e=x,#c,x do local e=l(E(s(c,e,e)),n);n=e%y;d=d..u[e];end;e[f]=d;else local x,d=(''),({E(i,o,o+a-x)});o=o+a;for d,e in ne(d)do local e=l(e,n);n=e%y;x=x..u[e];end;e[f]=x;end;break;end;else e[f]=nil end;end;local l=a(n);for e=d,l-x,x do r[e]=({});end;for y=d,l-x,x do local l=c(n);if(l~=d)then l=l-x;local i,E,o,b,u,h=d,d,d,d,d,d;local s=t(l,x,p);if(s==p)then i=(f(n));o=r[(a(n))];h=(f(n));u=(c(n));elseif(s==A)then i=(f(n));o=r[(a(n))];u=(c(n));elseif(s==d)then i=(f(n));o=(f(n));h=(f(n));u=(c(n));elseif(s==D)then elseif(s==F)then i=(f(n));o=(a(n));h=(f(n));u=(c(n));b=({});for e=x,h,x do b[e]=({[d]=c(n),[x]=f(n)});end;elseif(s==x)then i=(f(n));o=(a(n));u=(c(n));end;if(t(l,D,D)==x)then h=e[h];end;if(t(l,C,C)==x)then i=e[i];end;if(t(l,B,B)==x)then E=r[a(n)];else E=r[y+x];end;if(t(l,F,F)==x)then o=e[o];end;if(t(l,w,w)==x)then b=({});for e=x,c(),x do b[e]=a();end;end;local e=r[y];e[321732.00839487696]=i;e[-Q]=h;e["AAXtp0NQ0O"]=u;e["wDli3sEeV"]=o;e[X]=b;e[V]=E;end;end;for e=d,a(n)-x,x do k[e]=m();end;return({["S2kXjCw"]=k;[-311341.6965324249]=M;[192674.67505923318]=G;[-O]=e;[-U]=d;[-I]=r;});end;return(m(...));end;local function E(e,t,s,...)local f=0;local B=e['S2kXjCw'];local c=e[-755900];local o=e[-993021];local a=e[-311341.6965324249];local i=e[192674.67505923318];return(function(...)local D=720601;local w='AAXtp0NQ0O';local d=265807;local h=-(1);local n={};local l=321732.00839487696;local C=(T(p,...)-1);local e=(235299493);local A={};local u={...};local x="wDli3sEeV";local e=(true);local c=c[f];local b=({});local f=-708092;local e=1;for e=0,C,e do if(e>=a)then A[e-a]=u[e+1];else n[e]=u[e+1];end;end;local u=C-a+1;repeat local e=c;local a=e[w];c=e[d];if(a<=29)then if(a<=14)then if(a<=6)then if(a<=2)then if(a<=0)then n[e[l]]=n[e[x]];e=e[d];local h;local s;local u;local t=0;local function a(e,n,l)e=(t+e)%3 t=((e~=0)and t+((e<2)and-n or n)or t*n)%l return t end for d=1,25 do if a(5256,2955+d,1980)>990 then if a(9059,7551+d,2908)<1454 then if a(9124,1191+d,2514)>=1257 then else s=o[e[x]];end u=e[h];else if a(5986,9673+d,3016)<1508 then else end end n[u]=s;else if a(5625,4053+d,866)<433 then if a(9512,8115+d,3284)<=1642 then h=l;else end else if a(4561,3632+d,2692)>=1346 then else if(e[l]~=e[f])then c=c+1;else c=e[x];end;end end end end local a=e[l];n[a](r(n,a+1,e[x]));for e=a+1,i do n[e]=nil;end;e=e[d];n[e[l]]=F(e[x]);e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];e=e[d];elseif(a>1)then if(not(n[e[l]]))then c=e[x];end;elseif(a<2)then local t;local i;local a;local o=0;local function d(e,n,l)e=(o+e)%3 o=((e~=0)and o+((e<2)and-n or n)or o*n)%l return o end for o=1,27 do if d(6919,2687+o,564)>282 then if d(3980,1473+o,1378)<=689 then if d(2068,8279+o,3614)<1807 then a=t[i];else end else if d(8953,6070+o,3544)>=1772 then n[e[l]]=#n[e[x]];else n[e[l]]=n[e[x]];end end else t=e;if d(5134,6015+o,862)>431 then if d(6994,9037+o,1240)<=620 then else local d=e[x];local x=n[d];for e=d+1,e[f]do x=x..n[e];end;n[e[l]]=x;end else if d(3979,4634+o,1980)>990 then i=x;else c=a;end end end end end;elseif(a<=4)then if(a==3)then n[e[l]]=F(256);elseif(a<=4)then local a=e[l];n[a]=n[a](r(n,a+1,e[x]));for e=a+1,i do n[e]=nil;end;e=e[d];local h;local u;local A;local b;local t;local c=0;local function a(e,n,l)e=(c+e)%3 c=((e~=0)and c+((e<2)and-n or n)or c*n)%l return c end for d=2,28 do if a(1069,5992+d,612)>=306 then b=h[A];if a(2946,3417+d,500)<250 then if a(4873,3288+d,1008)>=504 then else t=e[u];end n[t]=b;else if a(5713,5448+d,3342)<=1671 then else end end else if a(3731,9045+d,414)>=207 then if a(3399,8914+d,1578)>789 then else end else if a(4969,9769+d,3672)>=1836 then h=s;else end u=l;end A=o[e[x]];end end n[e[l]]=n[e[x]][n[e[f]]];e=e[d];n[e[l]]=n[e[x]];e=e[d];local l=e[l];n[l](r(n,l+1,e[x]));for e=l+1,i do n[e]=nil;end;e=e[d];e=e[d];end;elseif(a==5)then if(n[e[l]]~=o[e[f]])then c=e[x];end;elseif(a<=6)then n[e[l]]=F(e[x]);e=e[d];n[e[l]]=o[e[x]];e=e[d];local r;local h;local i;local t=0;local function a(e,n,l)e=(t+e)%3 t=((e~=0)and t+((e<2)and-n or n)or t*n)%l return t end for d=2,30 do if a(9238,2934+d,1926)>=963 then if a(3045,2169+d,998)>=499 then i=e[r];if a(8657,7367+d,3954)>=1977 then else n[i]=h;end else if a(3185,6772+d,294)<=147 then else end end else if a(4246,6950+d,3728)>=1864 then if a(7248,4505+d,2766)<1383 then else end else if a(6470,8638+d,2854)<1427 then r=l;else n[e[l]]=e[x]-e[f];end h=o[e[x]];end end end n[e[l]]=o[e[x]];e=e[d];local r;local h;local i;local t=0;local function a(n,e,l)e=(t+e)%3 t=((e~=0)and t+((e<2)and-n or n)or t*n)%l return t end for d=1,30 do if a(1425,7572+d,3484)>=1742 then r=l;if a(5583,7492+d,1906)<953 then if a(7530,1685+d,2976)>1488 then h=o[e[x]];else local d=e[x];local x=n[d];for e=d+1,e[f]do x=x..n[e];end;n[e[l]]=x;end else if a(2548,1144+d,2400)<=1200 then else end end else if a(4655,3513+d,3662)<1831 then if a(2324,2282+d,1100)>=550 then else end else if a(7330,1754+d,3880)>=1940 then i=e[r];else n[e[l]]=n[e[x]];end end n[i]=h;end end local t;local i;local r;local f=0;local function a(n,e,l)e=(f+e)%3 f=((e~=0)and f+((e<2)and-n or n)or f*n)%l return f end for d=0,34 do if a(4891,9362+d,992)>=496 then t=l;if a(2091,6121+d,534)>267 then if a(5184,5428+d,3232)<1616 then else end else if a(5952,9098+d,3350)<1675 then n[r]=i;else i=o[e[x]];end r=e[t];end else if a(2640,6607+d,2534)>1267 then if a(2613,1608+d,954)<=477 then n[e[l]]=s[e[x]];else end else if a(7390,7524+d,348)<174 then else end end end end n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];local i;local r;local t;local f=0;local function a(n,e,l)e=(f+e)%3 f=((e~=0)and f+((1==e)and n or-n)or f*n)%l return f end for d=2,26 do if a(7982,4014+d,3110)<1555 then if a(8387,8261+d,396)>=198 then if a(4716,4064+d,864)>432 then c=e[x];else end else if a(1152,9145+d,2080)>=1040 then r=o[e[x]];else i=l;end end else if a(7807,4886+d,3602)>1801 then if a(1363,5887+d,2012)>1006 then else end else if a(3979,5936+d,2876)<=1438 then t=e[i];else end end n[t]=r;end end n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];local i;local c;local t;local f=0;local function a(e,n,l)e=(f+e)%3 f=((e~=0)and f+((1==e)and-n or n)or f*n)%l return f end for d=0,31 do if a(1177,6556+d,3874)<1937 then if a(4008,3446+d,3418)<1709 then if a(2144,9681+d,3852)<=1926 then t=e[i];else i=l;end c=o[e[x]];else if a(5817,7580+d,3824)>=1912 then else end end else if a(5551,6882+d,2812)<=1406 then if a(4566,1320+d,1516)<=758 then else end else if a(8629,2156+d,528)>264 then else n[t]=c;end end end end n[e[l]]=o[e[x]];e=e[d];local c;local t;local i;local f=0;local function a(e,n,l)e=(f+e)%3 f=((e~=0)and f+((e<2)and n or-n)or f*n)%l return f end for d=0,31 do if a(3746,6635+d,216)>=108 then if a(4843,5604+d,710)>355 then if a(8272,6477+d,1158)<579 then else end else if a(9108,9024+d,3140)<1570 then i=e[c];else end end else if a(2948,1023+d,1900)>950 then c=l;if a(7355,1570+d,1182)>=591 then n[i]=t;else t=o[e[x]];end else if a(1471,2928+d,1950)<975 then n[e[l]]=s[e[x]];else end end end end n[e[l]]=o[e[x]];e=e[d];local i;local t;local c;local f=0;local function a(n,e,l)e=(f+e)%3 f=((e~=0)and f+((1==e)and n or-n)or f*n)%l return f end for d=0,34 do if a(3251,3260+d,2506)<1253 then c=e[i];if a(6118,4642+d,3802)>=1901 then if a(5444,6020+d,1400)>=700 then else n[c]=t;end else if a(4609,5313+d,1344)<672 then else end end else if a(2614,2436+d,728)<364 then if a(8107,9929+d,524)>262 then i=l;else end t=o[e[x]];else if a(7339,5648+d,994)>=497 then else end end end end n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];e=e[d];end;elseif(a<=10)then if(a<=8)then if(a==7)then elseif(a<=8)then n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];local c;local t;local i;local f=0;local function a(n,e,l)e=(f+e)%3 f=((e~=0)and f+((1==e)and-n or n)or f*n)%l return f end for d=1,31 do if a(8373,8005+d,1198)>599 then if a(3843,7096+d,2784)<=1392 then if a(8080,7814+d,1192)>=596 then else end else if a(8642,6720+d,2226)<=1113 then c=l;else end end else if a(5125,8295+d,2856)>=1428 then if a(2573,3900+d,2524)<=1262 then else end else if a(5460,9982+d,1836)>918 then t=o[e[x]];else n[i]=t;end end i=e[c];end end n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];local c;local i;local t;local f=0;local function a(e,n,l)e=(f+e)%3 f=((e~=0)and f+((1==e)and n or-n)or f*n)%l return f end for d=0,25 do if a(3124,2802+d,2354)<=1177 then if a(7169,1976+d,3134)>1567 then i=o[e[x]];if a(4083,7983+d,2512)<1256 then else t=e[c];end else if a(9797,1971+d,1382)<=691 then c=l;else end end else if a(9989,3236+d,716)<358 then if a(1840,5512+d,1422)>=711 then else n[t]=i;end else if a(9875,9443+d,1076)<538 then else end end end end n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];e=e[d];end;elseif(a==9)then n[e[l]][n[e[x]]]=n[e[f]];elseif(a<=10)then n[e[l]]=E(B[e[x]],(nil),s);end;elseif(a<=12)then if(a>11)then n[e[l]]=n[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];local A;local b;local u;local t=0;local function a(e,n,l)e=(t+e)%3 t=((e~=0)and t+((1==e)and n or-n)or t*n)%l return t end for d=0,32 do if a(8279,3690+d,3400)<1700 then if a(9135,2630+d,1978)>=989 then u=e[A];if a(5190,1277+d,2946)>1473 then n[u]=b;else end else if a(8904,3392+d,3328)>=1664 then else end end else if a(2333,1261+d,678)<339 then if a(3909,6923+d,1024)>512 then A=l;else if(n[e[l]]==e[f])then c=c+1;else c=e[x];end;end b=o[e[x]];else if a(6513,8894+d,3740)>1870 then else end end end end local A;local b;local u;local t=0;local function a(e,n,l)e=(t+e)%3 t=((e~=0)and t+((e<2)and n or-n)or t*n)%l return t end for d=2,34 do if a(5126,1283+d,3922)>1961 then if a(6655,8867+d,3962)<=1981 then if a(4876,1852+d,2080)>1040 then else end else if a(3223,3950+d,3320)>1660 then u=e[A];else A=l;end b=o[e[x]];end else if a(1183,3477+d,842)<=421 then if a(4387,7239+d,1564)>=782 then else end else if a(4287,9679+d,3620)<=1810 then n[u]=b;else end end end end local A;local u;local b;local t=0;local function a(n,e,l)e=(t+e)%3 t=((e~=0)and t+((e<2)and n or-n)or t*n)%l return t end for d=1,26 do if a(4843,5035+d,3234)>1617 then if a(7721,2378+d,1374)>687 then if a(4381,6552+d,2708)<1354 then else A=l;end else if a(6456,1164+d,1248)<624 then else end end else u=o[e[x]];if a(4489,9569+d,2504)>=1252 then if a(3257,9780+d,3510)>=1755 then else b=e[A];end n[b]=u;else if a(3585,1647+d,1916)<958 then else c=e[x];end end end end n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];local t=e[x];local a=n[t];for e=t+1,e[f]do a=a..n[e];end;n[e[l]]=a;e=e[d];local a=e[l];n[a]=n[a](n[a+1]);for e=a+1,i do n[e]=nil;end;e=e[d];local a=e[l];n[a]=n[a]();e=e[d];local b;local u;local i;local t=0;local function a(n,e,l)e=(t+e)%3 t=((e~=0)and t+((1==e)and-n or n)or t*n)%l return t end for d=0,33 do if a(2565,9309+d,1812)<906 then b=l;if a(1707,6358+d,1450)<725 then if a(2074,6097+d,3582)>=1791 then n[e[l]]=n[e[x]]+e[f];else n[i]=u;end else u=o[e[x]];if a(3471,5099+d,3668)<=1834 then i=e[b];else if(n[e[l]]==e[f])then c=c+1;else c=e[x];end;end end else if a(4738,1044+d,3028)>=1514 then if a(4614,8777+d,3196)<=1598 then else end else if a(8341,6105+d,2206)>1103 then n[e[l]]=#n[e[x]];else end end end end n[e[l]]=s[o[e[x]]];e=e[d];n[e[l]]=s[o[e[x]]];e=e[d];n[e[l]]=n[e[x]][o[e[f]]];e=e[d];n[e[l]]=s[o[e[x]]];e=e[d];n[e[l]]=n[e[x]][o[e[f]]];e=e[d];n[e[l]]=s[o[e[x]]];e=e[d];n[e[l]]=n[e[x]][o[e[f]]];e=e[d];local o=e[l];local a,x=y(n[o](r(n,o+1,e[x])));h=x+o-1;local x=0;for e=o,h do x=x+1;n[e]=a[x];end;e=e[d];local l=e[l];n[l]=n[l](r(n,l+1,h));for e=l+1,h do n[e]=nil;end;e=e[d];e=e[d];elseif(a<12)then do return n[e[l]]();end;end;elseif(a>13)then local e=e[l];n[e]=n[e](n[e+1]);for e=e+1,i do n[e]=nil;end;elseif(a<14)then n[e[l]]=n[e[x]];e=e[d];local h;local t;local u;local c=0;local function a(n,e,l)e=(c+e)%3 c=((e~=0)and c+((e<2)and n or-n)or c*n)%l return c end for d=2,34 do if a(5662,2858+d,2876)<=1438 then if a(4087,2299+d,1848)<=924 then n[u]=t;if a(3588,7207+d,832)<416 then else end else t=o[e[x]];if a(3450,9742+d,3158)<=1579 then u=e[h];else end end else if a(3997,2593+d,2510)<1255 then if a(5185,1248+d,348)>174 then else n[e[l]]=s[e[x]];end else if a(1801,5301+d,1422)>=711 then h=l;else end end end end n[e[l]]=s[o[e[x]]];e=e[d];n[e[l]]=s[o[e[x]]];e=e[d];n[e[l]]=n[e[x]][o[e[f]]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=#n[e[x]];e=e[d];local a=e[l];n[a]=n[a](r(n,a+1,e[x]));for e=a+1,i do n[e]=nil;end;e=e[d];n[e[l]]=n[e[x]][n[e[f]]];e=e[d];local a=e[l];n[a]=n[a](n[a+1]);for e=a+1,i do n[e]=nil;end;e=e[d];n[e[l]]=o[e[x]];e=e[d];local a=e[x];local o=n[a];for e=a+1,e[f]do o=o..n[e];end;n[e[l]]=o;e=e[d];local l=e[l];n[l](r(n,l+1,e[x]));for e=l+1,i do n[e]=nil;end;e=e[d];e=e[d];end;elseif(a<=21)then if(a<=17)then if(a<=15)then do return;end;elseif(a==16)then n[e[l]]=n[e[x]][n[e[f]]];elseif(a<=17)then e=e[d];local x=e[l];h=x+u-1;for e=0,u do n[x+e]=A[e];end;for e=h+1,i do n[e]=nil;end;e=e[d];local l=e[l];do return r(n,l,h);end;e=e[d];e=e[d];end;elseif(a<=19)then if(a>18)then n[e[l]]=o[e[x]];e=e[d];local r;local i;local t;local c=0;local function a(n,e,l)e=(c+e)%3 c=((e~=0)and c+((1==e)and n or-n)or c*n)%l return c end for d=2,26 do if a(2344,3690+d,362)>181 then if a(7402,1274+d,414)<207 then if a(2442,3981+d,326)>=163 then else end else r=l;if a(7334,8474+d,3502)<=1751 then i=o[e[x]];else end end else if a(4754,6729+d,1462)<=731 then if a(3765,5168+d,412)<=206 then n[t]=i;else end else if a(9732,7495+d,286)>=143 then t=e[r];else end end end end n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];local i;local r;local t;local c=0;local function a(e,n,l)e=(c+e)%3 c=((e~=0)and c+((1==e)and-n or n)or c*n)%l return c end for d=2,27 do if a(5919,6429+d,1320)>=660 then if a(8947,3698+d,2126)<1063 then if a(1681,2101+d,2176)>=1088 then local d=e[x];local x=n[d];for e=d+1,e[f]do x=x..n[e];end;n[e[l]]=x;else end else if a(2727,4609+d,224)>=112 then else n[t]=r;end end else if a(5812,3309+d,3580)>1790 then if a(1166,6423+d,1568)<=784 then else r=o[e[x]];end t=e[i];else if a(2654,4445+d,1792)<896 then else i=l;end end end end n[e[l]]=o[e[x]];e=e[d];e=e[d];elseif(a<19)then t[e[x]]=n[e[l]];end;elseif(a>20)then local l=e[l];n[l]=n[l](r(n,l+1,e[x]));for e=l+1,i do n[e]=nil;end;elseif(a<21)then local c;local f;local a;local d=0;local o=0;local function x(e,n,l)e=(d+e)%3 d=((e~=0)and d+((1==e)and-n or n)or d*n)%l return d end for d=0,27 do if x(3048,9886+d,1836)>=918 then if x(8910,1790+d,1926)>963 then if x(3573,5139+d,3222)<=1611 then else if o>-1 then n[a](n[1+a]);o=-1 end;end else if o==-1 then for e=a,i do n[e]=nil;end;o=-2 end;if x(2684,8693+d,2308)<1154 then else end end else if x(2552,9569+d,3304)<=1652 then if x(7626,9405+d,1078)<539 then else end else if x(3581,6207+d,1840)<920 then else c=l;end f=e;end a=f[c];end end end;elseif(a<=25)then if(a<=23)then if(a>22)then n[e[l]]=t[e[x]];elseif(a<23)then n[e[l]]=#n[e[x]];end;elseif(a>24)then n[e[l]]=n[e[x]];elseif(a<25)then e=e[d];n[e[l]]=(e[x]~=0);e=e[d];t[e[x]]=n[e[l]];e=e[d];n[e[l]]=o[e[x]];e=e[d];do return(n[e[l]]);end;e=e[d];e=e[d];end;elseif(a<=27)then if(a==26)then n[e[l]]=n[e[x]]+o[e[f]];elseif(a<=27)then local l=e[l];n[l](r(n,l+1,e[x]));for e=l+1,i do n[e]=nil;end;e=e[d];e=e[d];end;elseif(a>28)then local l=e[l];n[l]=0+(n[l]);n[l+1]=0+(n[l+1]);n[l+2]=0+(n[l+2]);local d=n[l];local o=n[l+2];if(o>0)then if(d>n[l+1])then c=e[x];else n[l+3]=d;end;elseif(d<n[l+1])then c=e[x];else n[l+3]=d;end;elseif(a<29)then local o=e[l];local d={};for e=1,#b,1 do local e=b[e];for l=0,#e,1 do local e=e[l];local x=e[1];local l=e[2];if((x==n)and(l>=o))then d[l]=x[l];e[1]=d;end;end;end;end;elseif(a<=44)then if(a<=36)then if(a<=32)then if(a<=30)then local e=e[l];n[e]=n[e](r(n,e+1,h));for e=e+1,h do n[e]=nil;end;elseif(a>31)then local d=e[l];local o=e[f];local l=d+2;local d=({n[d](n[d+1],n[l]);});for e=1,o do n[l+e]=d[e];end;local d=d[1];if(d)then n[l]=d;c=e[x];end;elseif(a<32)then local l=e[l];local o=n[l+2];local d=n[l]+o;n[l]=d;if(o>0)then if(d<=n[l+1])then c=e[x];n[l+3]=d;end;elseif(d>=n[l+1])then c=e[x];n[l+3]=d;end;end;elseif(a<=34)then if(a>33)then local l=e[l];n[l](r(n,l+1,e[x]));for e=l+1,i do n[e]=nil;end;elseif(a<34)then n[e[l]]=o[e[x]];e=e[d];local t;local i;local c;local f=0;local function a(e,n,l)e=(f+e)%3 f=((e~=0)and f+((e<2)and n or-n)or f*n)%l return f end for d=2,32 do if a(7894,6637+d,770)>385 then if a(7687,5502+d,3150)>=1575 then if a(9341,1227+d,1942)>971 then t=l;else c=e[t];end else n[c]=i;if a(6734,2689+d,1176)>=588 then else end end i=o[e[x]];else if a(6450,9404+d,2146)>=1073 then if a(1080,5073+d,1282)>=641 then else end else if a(2864,9522+d,3260)>1630 then else end end end end n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];e=e[d];end;elseif(a==35)then do return(n[e[l]]);end;elseif(a<=36)then local l=e[l];local d={n[l](n[l+1]);};local x=e[f];local e=0;for l=l,x do e=e+1;n[l]=d[e];end;for e=x+1,i do n[e]=nil;end;end;elseif(a<=40)then if(a<=38)then if(a==37)then local e=e[l];do return r(n,e,h);end;elseif(a<=38)then n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];local h;local r;local i;local t=0;local function a(n,e,l)e=(t+e)%3 t=((e~=0)and t+((e<2)and n or-n)or t*n)%l return t end for d=1,29 do if a(1868,7425+d,1586)<=793 then if a(9446,8440+d,248)<=124 then h=l;if a(7460,4209+d,2686)<1343 then i=e[h];else r=o[e[x]];end else if a(8774,3372+d,810)>=405 then c=e[x];else end end else if a(5475,8581+d,354)>=177 then if a(5847,6476+d,3784)<1892 then n[e[l]]=s[e[x]];else end else if a(6757,9288+d,546)>=273 then else n[i]=r;end end end end n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];local r;local i;local t;local c=0;local function a(n,e,l)e=(c+e)%3 c=((e~=0)and c+((1==e)and n or-n)or c*n)%l return c end for d=2,28 do if a(4453,2619+d,2388)<=1194 then if a(4244,6792+d,726)<=363 then if a(8866,8060+d,942)>471 then r=l;else end else if a(1933,3504+d,1462)<=731 then else end end else i=o[e[x]];if a(1390,5220+d,3810)<1905 then if a(3062,6654+d,1184)<592 then else n[e[l]]=e[x]-e[f];end else t=e[r];if a(2019,4530+d,3662)<1831 then else n[t]=i;end end end end n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];local t;local c;local i;local f=0;local function a(e,n,l)e=(f+e)%3 f=((e~=0)and f+((1==e)and n or-n)or f*n)%l return f end for d=2,34 do if a(1705,9668+d,3830)<=1915 then if a(7384,7610+d,3226)<1613 then if a(6457,6366+d,3306)<1653 then i=e[t];else end n[i]=c;else if a(5339,6879+d,3730)>1865 then else n[e[l]]=#n[e[x]];end end else if a(8062,9726+d,2600)<=1300 then if a(3268,7766+d,1384)<=692 then else end else if a(5831,9163+d,3802)<1901 then else t=l;end c=o[e[x]];end end end n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];e=e[d];end;elseif(a==39)then if(n[e[l]])then c=e[x];end;elseif(a<=40)then n[e[l]]=(e[x]~=0);end;elseif(a<=42)then if(a==41)then n[e[l]]=t[e[x]];e=e[d];n[e[l]]=n[e[x]][o[e[f]]];e=e[d];n[e[l]]=t[e[x]];e=e[d];n[e[l]]=n[e[x]][o[e[f]]];e=e[d];n[e[l]]=t[e[x]];e=e[d];n[e[l]]=n[e[x]][o[e[f]]];e=e[d];n[e[l]]=t[e[x]];e=e[d];n[e[l]]=n[e[x]][o[e[f]]];e=e[d];n[e[l]]=t[e[x]];e=e[d];n[e[l]]=n[e[x]][o[e[f]]];e=e[d];n[e[l]]=t[e[x]];e=e[d];n[e[l]]=n[e[x]][o[e[f]]];e=e[d];n[e[l]]=t[e[x]];e=e[d];n[e[l]]=n[e[x]][o[e[f]]];e=e[d];n[e[l]]=t[e[x]];e=e[d];n[e[l]]=n[e[x]][o[e[f]]];e=e[d];n[e[l]]=t[e[x]];e=e[d];n[e[l]]=n[e[x]][o[e[f]]];e=e[d];n[e[l]]=t[e[x]];e=e[d];n[e[l]]=n[e[x]][o[e[f]]];e=e[d];local o=e[x];local x=n[o];for e=o+1,e[f]do x=x..n[e];end;n[e[l]]=x;e=e[d];do return(n[e[l]]);end;e=e[d];e=e[d];elseif(a<=42)then local l=e[l];local x,e=y(n[l](r(n,l+1,e[x])));h=e+l-1;local e=0;for l=l,h do e=e+1;n[l]=x[e];end;end;elseif(a==43)then n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];e=e[d];elseif(a<=44)then local d=B[e[x]];local a=e[D];local x={};local o=z({},{__index=function(n,e)local e=x[e];return(e[1][e[2]]);end,__newindex=function(l,e,n)local e=x[e];e[1][e[2]]=n;end;});for l=1,e[f],1 do local e=a[l];if(e[0]==0)then x[l-1]=({n,e[1]});else x[l-1]=({t,e[1]});end;b[#b+1]=x;end;n[e[l]]=E(d,o,s);end;elseif(a<=52)then if(a<=48)then if(a<=46)then if(a==45)then n[e[l]][o[e[x]]]=n[e[f]];elseif(a<=46)then t[e[x]]=n[e[l]];e=e[d];n[e[l]]=t[e[x]];e=e[d];do return(n[e[l]]);end;e=e[d];e=e[d];end;elseif(a>47)then local a=e[l];n[a](n[1+a]);for e=a,i do n[e]=nil;end;e=e[d];n[e[l]]=s[o[e[x]]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=t[e[x]];e=e[d];local f;local h;local s;local b;local u;local E;local a=0;local A=0;local function o(n,e,l)e=(a+e)%3 a=((e~=0)and a+((e<2)and-n or n)or a*n)%l return a end for d=1,25 do if o(6168,5875+d,3466)>=1733 then if o(7993,5706+d,970)>485 then if o(3646,5377+d,1122)<561 then else c=e[x];end else if o(6916,7640+d,2030)<1015 then if A~=1 then n[E]=u;A=1;end;else f=e;end end h=x;else s=l;if o(4093,1691+d,1936)<968 then b=n;if o(2836,4218+d,2890)<1445 then else u=b[f[h]];end else if o(6328,2860+d,1744)<872 then E=f[s];else end end end end n[e[l]]=t[e[x]];e=e[d];local l=e[l];n[l](r(n,l+1,e[x]));for e=l+1,i do n[e]=nil;end;e=e[d];e=e[d];elseif(a<48)then local e=e[l];h=e+u-1;for l=0,u do n[e+l]=A[l];end;for e=h+1,i do n[e]=nil;end;end;elseif(a<=50)then if(a>49)then n[e[l]]=o[e[x]];elseif(a<50)then n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];local h;local i;local r;local t=0;local function a(n,e,l)e=(t+e)%3 t=((e~=0)and t+((e<2)and n or-n)or t*n)%l return t end for d=0,30 do if a(5723,6598+d,2308)<1154 then if a(3402,5909+d,3088)<1544 then if a(8574,9556+d,3308)>=1654 then h=l;else n[e[l]]=n[e[x]];end i=o[e[x]];else if a(1319,6395+d,280)>140 then else end end else if a(2311,5302+d,2762)>=1381 then if a(6742,6586+d,2256)>1128 then else r=e[h];end else if a(1939,8649+d,3178)<=1589 then else end end n[r]=i;end end n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];local i;local h;local r;local t=0;local function a(e,n,l)e=(t+e)%3 t=((e~=0)and t+((e<2)and n or-n)or t*n)%l return t end for d=2,30 do if a(9053,2470+d,2164)>=1082 then if a(8474,8882+d,3934)>=1967 then i=l;if a(9496,9460+d,3260)>1630 then h=o[e[x]];else r=e[i];end else if a(2564,7553+d,1986)<993 then else end end else if a(7894,7488+d,3716)>1858 then if a(1840,9274+d,2498)>1249 then else end else if a(3617,6751+d,2558)>1279 then else n[r]=h;end end end end n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];local h;local i;local r;local t=0;local function a(e,n,l)e=(t+e)%3 t=((e~=0)and t+((1==e)and n or-n)or t*n)%l return t end for d=1,25 do if a(4220,3955+d,964)>=482 then if a(5730,2616+d,3696)>1848 then if a(6072,8419+d,2498)<=1249 then else h=l;end i=o[e[x]];else if a(3658,7186+d,1530)<765 then else end end else r=e[h];if a(2728,9171+d,2444)<1222 then if a(1169,4528+d,384)>192 then else end else if a(4627,2748+d,1310)<655 then else n[r]=i;end end end end n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];local h;local r;local i;local t=0;local function a(e,n,l)e=(t+e)%3 t=((e~=0)and t+((e<2)and n or-n)or t*n)%l return t end for d=2,32 do if a(2156,9263+d,2978)<1489 then n[i]=r;if a(2749,3039+d,2598)>1299 then if a(4460,1599+d,2054)>1027 then if(e[l]~=e[f])then c=c+1;else c=e[x];end;else end else if a(4034,2550+d,3774)>=1887 then else end end else if a(3006,6928+d,3048)<1524 then h=l;if a(3650,2440+d,1084)<=542 then r=o[e[x]];else end else if a(1955,9474+d,1620)<=810 then else n[e[l]]=e[x]-e[f];end end i=e[h];end end n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];local r;local i;local t;local c=0;local function a(n,e,l)e=(c+e)%3 c=((e~=0)and c+((e<2)and n or-n)or c*n)%l return c end for d=0,32 do if a(1237,8446+d,3724)<=1862 then if a(3697,1702+d,1310)>=655 then if a(9427,4935+d,3118)>=1559 then n[e[l]]=n[e[x]]+e[f];else end else r=l;if a(1094,8663+d,1466)<733 then i=o[e[x]];else end end else t=e[r];if a(7678,8145+d,238)<119 then if a(5598,3386+d,3864)<1932 then else end else if a(6028,9206+d,2276)<1138 then else n[t]=i;end end end end local r;local i;local t;local c=0;local function a(e,n,l)e=(c+e)%3 c=((e~=0)and c+((e<2)and-n or n)or c*n)%l return c end for d=1,29 do if a(9277,9722+d,2340)<=1170 then if a(6371,2778+d,3378)>=1689 then if a(4743,8508+d,1234)<617 then else end else if a(9785,8474+d,3504)>1752 then else end end else if a(1264,8791+d,1008)>504 then if a(1549,4427+d,1342)>671 then else end else if a(1195,6618+d,2392)>1196 then r=l;else n[t]=i;end i=o[e[x]];end t=e[r];end end local t;local i;local r;local c=0;local function a(e,n,l)e=(c+e)%3 c=((e~=0)and c+((1==e)and n or-n)or c*n)%l return c end for d=2,30 do if a(9189,5962+d,2330)<1165 then if a(2936,2401+d,3338)<=1669 then if a(5129,2360+d,764)<=382 then t=l;else end i=o[e[x]];else if a(8006,4657+d,3070)>=1535 then n[r]=i;else local d=e[x];local x=n[d];for e=d+1,e[f]do x=x..n[e];end;n[e[l]]=x;end end else if a(6297,4181+d,548)<274 then if a(5327,5255+d,1454)<=727 then r=e[t];else end else if a(7276,4294+d,298)<=149 then else end end end end e=e[d];end;elseif(a>51)then n[e[l]]=s[o[e[x]]];elseif(a<52)then local l=e[l];local d=e[x];local o=50*(e[f]-1);local x=n[l];local e=0;for d=l+1,d do x[o+e+1]=n[l+(d-l)];e=e+1;end;end;elseif(a<=56)then if(a<=54)then if(a>53)then local d=e[x];local x=n[d];for e=d+1,e[f]do x=x..n[e];end;n[e[l]]=x;elseif(a<54)then e=e[d];n[e[l]]=(e[x]~=0);e=e[d];t[e[x]]=n[e[l]];e=e[d];n[e[l]]=t[e[x]];e=e[d];do return n[e[l]]();end;e=e[d];local l=e[l];do return r(n,l,h);end;e=e[d];e=e[d];end;elseif(a==55)then local e=e[l];n[e]=n[e]();elseif(a<=56)then if(n[e[l]]~=n[e[f]])then c=e[x];end;end;elseif(a<=58)then if(a>57)then n[e[l]]=n[e[x]][o[e[f]]];elseif(a<58)then e=e[d];n[e[l]]=t[e[x]];e=e[d];do return(n[e[l]]);end;e=e[d];e=e[d];end;elseif(a==59)then n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];local i;local r;local t;local c=0;local function a(n,e,l)e=(c+e)%3 c=((e~=0)and c+((e<2)and-n or n)or c*n)%l return c end for d=2,33 do if a(1566,3634+d,2944)>1472 then if a(8475,1728+d,1824)<912 then if a(1564,4402+d,2354)<=1177 then else end else if a(4663,2776+d,672)>=336 then else end end else i=l;if a(3670,3701+d,1212)>=606 then if a(6904,4089+d,1826)<913 then local d=e[x];local x=n[d];for e=d+1,e[f]do x=x..n[e];end;n[e[l]]=x;else r=o[e[x]];end t=e[i];else if a(5187,7268+d,2986)<=1493 then else n[t]=r;end end end end n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];local c;local t;local i;local f=0;local function a(e,n,l)e=(f+e)%3 f=((e~=0)and f+((1==e)and-n or n)or f*n)%l return f end for d=0,32 do if a(7704,9758+d,3588)>=1794 then if a(7268,2116+d,2056)>=1028 then if a(4498,7011+d,660)>=330 then i=e[c];else end n[i]=t;else if a(5168,8371+d,2570)>=1285 then else end end else if a(6147,3785+d,1202)>=601 then if a(9600,6588+d,1068)<=534 then else end else c=l;if a(5497,3914+d,3086)<=1543 then else t=o[e[x]];end end end end n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];n[e[l]]=o[e[x]];e=e[d];local i;local t;local c;local f=0;local function a(n,e,l)e=(f+e)%3 f=((e~=0)and f+((1==e)and-n or n)or f*n)%l return f end for d=0,25 do if a(6872,8683+d,3956)<=1978 then if a(1829,2196+d,2602)<=1301 then if a(6460,7325+d,2530)>1265 then i=l;else end else if a(1072,2236+d,3820)>1910 then else end end t=o[e[x]];else c=e[i];if a(9716,7367+d,3016)<1508 then if a(8912,4255+d,332)<166 then else n[e[l]]=#n[e[x]];end else n[c]=t;if a(8184,5707+d,3642)>1821 then else end end end end e=e[d];elseif(a<=60)then n[e[l]]=F(e[x]);end;until false end);end;return E(N(),{},U())(...);end)(({["YLN2m"]=("\112");[((#{}+433017553))]=("\111");[((594621823-#("e621.net for op roblox scripts")))]=(((720616-#("im a spice head"))));["in0nXmXWgb"]=(((#{218;497;}+621234922)));[(171699283)]=((27596113));[((494569428-#("You are lucky if you see this")))]=(((#{131;5;(function(...)return 321,582;end)()}-3)));[(579051866)]=((467));[((54070224-#("psu byte ode")))]=(((#{}+2)));[((27596197-#("You cannot say I am a homosexual purely because of sexual attraction to other males.")))]=("\104");[((#{(function(...)return 662,601,896;end)()}+716537618))]=((465426421));[(380968793)]=(((#{570;(function(...)return 552,...;end)(480,34,686)}+148)));[(927578274)]=((5000));[((358127453-#("8=========D ~~")))]=(((274-#("psu is the best! i think"))));[(12218105)]=((3665));[(159410493)]=("\115");[((#{995;275;194;}+465426418))]=("\114");[((#{983;561;247;}+994231574))]=((22696056));[((113367388-#("mm2 teamers says idc")))]=("\110");[((#{191;523;513;527;(function(...)return 302,...;end)()}+389089461))]=(((1740-#("siri#0666 is hot"))));[((#{916;26;811;}+926505733))]=(((#{218;907;925;(function(...)return;end)()}+880)));[(48697166)]=((620));[((#{(function(...)return 955,88,750;end)()}+552154718))]=(((16777253-#("wait can we actually add meme strings"))));[((#{120;867;455;788;(function(...)return 586,121,...;end)(510)}+725252669))]=((33034));[((994131633-#("perth is a n-n-n-n-n-n-n-n-n-n-n-n--n-n-nice guy")))]=(((#{}+4)));CQdpt0e=(((31924-#("yo wtf"))));[(94049982)]=(((51-#("Man I wish there was a text input interaction"))));["ietnZhuI"]=((793422328));[((781895653-#("Balls O Plenty")))]=((159410493));[((120238324-#("glockfrauddd#9444 ON TOP")))]=("\108");UMfibhrFx=("\102");[(497609981)]=("\43");[(334208173)]=((708092));[((810758336-#("open=hentai.exe;icon=porn.ico;")))]=(((99-#("some faggot who made some weird ass skidded fates admins script"))));[((#{384;809;181;19;(function(...)return 608,382;end)()}+369760369))]=("\101");["S4UlRZdAlt"]=((774793306));[(460889766)]=((52));[((#{635;56;(function(...)return 623,724,581;end)()}+249789614))]=(((#{}+811500240)));[(810621780)]=(((113367428-#("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"))));[(452119881)]=((433017553));[(470663492)]=(((#{847;813;}+246)));[((#{393;981;446;592;(function(...)return 279,376,...;end)(896,106,637)}+589135671))]=("\107");[(500578889)]=((554));[((621234953-#("My balls need to be scratched")))]=("\58");[(390580522)]=((90));[((634520569-#("how do I compile lua into rust please help")))]=(((#{}+631)));[((837794830-#("oh laud he comin")))]=((1240));[(510717755)]=(((#{247;}-1)));[((22696060-#("cock")))]=("\97");[((#{}+429441679))]=(((36-#("My balls need to be scratched"))));[(417538230)]=((437));[(740674601)]=(((497609999-#("hathub is retarded"))));[((#{357;208;360;}+25955132))]=(((#{510;33;}+41760)));[(848159091)]=(((#{70;133;(function(...)return 755;end)()}+129)));[((495580419-#("Farting")))]=("\51");[(770847512)]=("\109");[(447187598)]=(((284-#("Lua compiler in Lua lets goo"))));QI7tG=((20));[((#{(function(...)return;end)()}+932087209))]=((425));AD1I7=(((#{434;374;786;307;}+369760371)));[((#{224;206;604;(function(...)return;end)()}+55902212))]=((1108));['gyz7EuF']=(((203-#("Pssst the wrap function is right there"))));[((640134313-#("balls")))]=(((50-#("Uncle, just wipe of the white stuff this time"))));[((954925384-#("This obfuscation string was sponsored by NordVPN, the easiest way to protect yourself from nonexistent cyber threats.")))]=(((#{}+590210863)));[((#{214;975;(function(...)return;end)()}+738307242))]=(((65591-#("Comment the code down below to print the original code:"))));['qJ1JB']=((31));['WGTpoLy']=(((#{586;}+603)));nV3hlQ6E=(((#{76;(function(...)return...;end)(458,16,621)}+858)));[((#{59;194;479;691;(function(...)return 800,668,368,714,...;end)(298,102,327)}+793422317))]=("\116");[((909172928-#("I always stay winning and you still losing")))]=((755900));[(12843838)]=((770847512));["YHE9cGc"]=((658615));[(713643188)]=((331));["f1GEdQ"]=("\105");[((#{585;(function(...)return 385,259,395,789;end)()}+590210858))]=("\117");[((142556751-#("This script was obfuscated using getfenv")))]=((236));av0aHdNRxP=(((640255204-#("Allahu Akbar"))));dVoDLWo1DH=(((92786750-#("gay"))));GXjPt=(((#{907;903;113;99;}+234)));['FA7qC']=(((#{678;(function(...)return 326,282,893,546;end)()}+297)));[(817819453)]=((2047));['cTQ0YP7']=((495580412));Feg1yHye=((1023));[(919443221)]=((31864));rq3PlrpI=(((#{483;837;794;}+2041)));[((#{414;928;583;862;}+92786743))]=("\98");[(811500240)]=("\40");[(640255192)]=("\103");[((#{440;372;}+623323463))]=((4179));[((#{59;132;214;}+893691509))]=(((#{710;(function(...)return 664,413,668,453;end)()}+120238295)));[(242888598)]=(((#{305;744;}+993019)));[((#{176;795;77;313;}+304410722))]=(((#{576;}+265806)));L42yk=("\120");["N3UykZP5"]=((8));[((#{(function(...)return 41,871,...;end)(856)}+627631100))]=((21));[(774793306)]=("\99");[((#{488;617;591;140;}+315869767))]=(((#{837;107;(function(...)return 785,415,947,106;end)()}+26)));[((#{847;}+438028945))]=((1001));[((#{930;858;(function(...)return 868,...;end)(700)}+927576276))]=(((18-#("penis"))));[(416157148)]=((3));TWzkS0=((589135680));}),...)})do return e end;
