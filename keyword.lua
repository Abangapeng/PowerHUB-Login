local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LinkingService = game:GetService("LinkingService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

--// ==========================================
--// KONFIGURASI
--// ==========================================

-- DATABASE KEY DARI GITHUB KAMU
local KEY_DATABASE_URL = "https://raw.githubusercontent.com/PanzzHack/key/refs/heads/main/keyword.lua"

-- SCRIPT UTAMA (Ganti ini dengan link script Cheat/GUI asli kamu)
local MAIN_SCRIPT_URL = "https://raw.githubusercontent.com/power-datebase/manu-utama/refs/heads/main/231011402540123.lua"

-- Link Tombol
local KEY_LINK = "https://powerhubofficial.netlify.app/"
local DISCORD_LINK = "https://discord.gg/exb7hSPZg"

-- Nama file untuk simpan data di HP
local FILE_NAME = "PowerHUB_Key.txt" 

--// ==========================================
--// SYSTEM SETUP
--// ==========================================

local function GetSafeParent()
    local success, result = pcall(function() return gethui() end)
    if success and result then return result end
    success, result = pcall(function() return game:GetService("CoreGui") end)
    if success and result then return result end
    local plr = Players.LocalPlayer
    if not plr then plr = Players:GetPropertyChangedSignal("LocalPlayer"):Wait() end
    return plr:WaitForChild("PlayerGui")
end

local parent = GetSafeParent()
if parent:FindFirstChild("PowerHUB_UI") then
    parent.PowerHUB_UI:Destroy()
end

--// ==========================================
--// FUNGSI SAVE/LOAD
--// ==========================================

local function SaveKey(key)
    if writefile then
        pcall(function() writefile(FILE_NAME, key) end)
    end
end

local function LoadKey()
    if isfile and isfile(FILE_NAME) then
        local success, result = pcall(function() return readfile(FILE_NAME) end)
        if success then return result end
    end
    return nil
end

--// ==========================================
--// UI CREATION
--// ==========================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PowerHUB_UI"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = parent
ScreenGui.Enabled = false -- Hidden by default (Auto-Check first)

-- MAIN FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- GRADASI BORDER (BIRU-UNGU)
local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 3
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Color = Color3.fromRGB(255, 255, 255)
MainStroke.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 255, 255)),   -- Cyan
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(0, 100, 255)),   -- Biru
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(150, 0, 255)),   -- Ungu
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 100, 255)),   -- Biru
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 255))    -- Cyan
})
MainGradient.Parent = MainStroke

task.spawn(function()
    local rotation = 0
    while MainStroke.Parent do
        rotation = rotation + 2
        MainGradient.Rotation = rotation
        task.wait(0.03)
    end
end)

-- HEADER & TITLE
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 0, 40)
Title.Position = UDim2.new(0, 15, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "PowerHUB"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Parent = MainFrame

-- RGB TITLE ANIMATION
task.spawn(function()
    while Title.Parent do
        local t = tick()
        local color = Color3.fromHSV((t % 5) / 5, 1, 1) 
        Title.TextColor3 = color
        task.wait(0.05)
    end
end)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -45, 0, 5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.Parent = MainFrame

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- CONTENT
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -30, 1, -55)
ContentFrame.Position = UDim2.new(0, 15, 0, 50)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 12)
UIListLayout.Parent = ContentFrame

-- INPUT KEY
local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(1, 0, 0, 38)
InputBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
InputBox.Text = ""
InputBox.PlaceholderText = "Paste Key Here..."
InputBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.Font = Enum.Font.Gotham
InputBox.TextSize = 14
InputBox.Parent = ContentFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 6)
InputCorner.Parent = InputBox

local InputStroke = Instance.new("UIStroke")
InputStroke.Thickness = 1
InputStroke.Color = Color3.fromRGB(60, 60, 60)
InputStroke.Parent = InputBox

-- BUTTONS
local ButtonRow = Instance.new("Frame")
ButtonRow.Size = UDim2.new(1, 0, 0, 38)
ButtonRow.BackgroundTransparency = 1
ButtonRow.Parent = ContentFrame

local RowLayout = Instance.new("UIListLayout")
RowLayout.FillDirection = Enum.FillDirection.Horizontal
RowLayout.Padding = UDim.new(0, 10)
RowLayout.Parent = ButtonRow

local function CreateButton(text, parentFrame)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.5, -5, 1, 0)
    Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 12
    Btn.Parent = parentFrame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Btn
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Thickness = 1
    Stroke.Color = Color3.fromRGB(60, 60, 60)
    Stroke.Parent = Btn
    return Btn
end

local GetKeyBtn = CreateButton("GET KEY", ButtonRow)
local ConfirmBtn = CreateButton("CONFIRM", ButtonRow)

-- DISCORD BUTTON
local DiscordBtn = Instance.new("TextButton")
DiscordBtn.Size = UDim2.new(1, 0, 0, 38)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
DiscordBtn.Text = "JOIN DISCORD"
DiscordBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
DiscordBtn.Font = Enum.Font.GothamBold
DiscordBtn.TextSize = 12
DiscordBtn.Parent = ContentFrame

local DiscordCorner = Instance.new("UICorner")
DiscordCorner.CornerRadius = UDim.new(0, 6)
DiscordCorner.Parent = DiscordBtn

local DiscordStroke = Instance.new("UIStroke")
DiscordStroke.Thickness = 1
DiscordStroke.Color = Color3.fromRGB(60, 60, 60)
DiscordStroke.Parent = DiscordBtn

--// ==========================================
--// NOTIFIKASI MODERN
--// ==========================================

local function ShowNotification(message, isError)
    local accentColor = isError and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(80, 255, 100)
    local iconText = isError and "!" or "✓"
    
    local NotifFrame = Instance.new("Frame")
    NotifFrame.Name = "NotifToast"
    NotifFrame.Size = UDim2.new(0, 260, 0, 40)
    NotifFrame.Position = UDim2.new(0.5, -130, 0.9, 0)
    NotifFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    NotifFrame.BackgroundTransparency = 1
    NotifFrame.ZIndex = 30
    NotifFrame.Parent = MainFrame

    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 6)
    NotifCorner.Parent = NotifFrame
    
    local NotifStroke = Instance.new("UIStroke")
    NotifStroke.Thickness = 1
    NotifStroke.Color = accentColor
    NotifStroke.Transparency = 1
    NotifStroke.Parent = NotifFrame

    local IconFrame = Instance.new("Frame")
    IconFrame.Size = UDim2.new(0, 24, 0, 24)
    IconFrame.Position = UDim2.new(0, 8, 0.5, -12)
    IconFrame.BackgroundColor3 = accentColor
    IconFrame.BackgroundTransparency = 1
    IconFrame.ZIndex = 31
    IconFrame.Parent = NotifFrame
    
    local IconCorner = Instance.new("UICorner")
    IconCorner.CornerRadius = UDim.new(1, 0)
    IconCorner.Parent = IconFrame
    
    local IconLabel = Instance.new("TextLabel")
    IconLabel.Size = UDim2.new(1, 0, 1, 0)
    IconLabel.BackgroundTransparency = 1
    IconLabel.Text = iconText
    IconLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
    IconLabel.Font = Enum.Font.GothamBlack
    IconLabel.TextSize = 14
    IconLabel.TextTransparency = 1
    IconLabel.ZIndex = 32
    IconLabel.Parent = IconFrame

    local MsgLabel = Instance.new("TextLabel")
    MsgLabel.Size = UDim2.new(1, -40, 1, 0)
    MsgLabel.Position = UDim2.new(0, 40, 0, 0)
    MsgLabel.BackgroundTransparency = 1
    MsgLabel.Text = message
    MsgLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    MsgLabel.Font = Enum.Font.GothamBold
    MsgLabel.TextSize = 12
    MsgLabel.TextXAlignment = Enum.TextXAlignment.Left
    MsgLabel.TextTransparency = 1
    MsgLabel.ZIndex = 31
    MsgLabel.Parent = NotifFrame

    local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    TweenService:Create(NotifFrame, tweenInfo, {BackgroundTransparency = 0.1, Position = UDim2.new(0.5, -130, 0.8, 0)}):Play()
    TweenService:Create(NotifStroke, tweenInfo, {Transparency = 0}):Play()
    TweenService:Create(IconFrame, tweenInfo, {BackgroundTransparency = 0}):Play()
    TweenService:Create(IconLabel, tweenInfo, {TextTransparency = 0}):Play()
    TweenService:Create(MsgLabel, tweenInfo, {TextTransparency = 0}):Play()

    task.wait(2.5)

    local tweenOut = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    TweenService:Create(NotifFrame, tweenOut, {BackgroundTransparency = 1, Position = UDim2.new(0.5, -130, 0.9, 0)}):Play()
    TweenService:Create(NotifStroke, tweenOut, {Transparency = 1}):Play()
    TweenService:Create(IconFrame, tweenOut, {BackgroundTransparency = 1}):Play()
    TweenService:Create(IconLabel, tweenOut, {TextTransparency = 1}):Play()
    TweenService:Create(MsgLabel, tweenOut, {TextTransparency = 1}):Play()

    task.wait(0.4)
    NotifFrame:Destroy()
end

--// ==========================================
--// LOGIC SYSTEM (AUTO CHECK)
--// ==========================================

task.spawn(function()
    -- 1. Cek Key di HP
    local savedKey = LoadKey()
    
    if savedKey then
        StarterGui:SetCore("SendNotification", {
            Title = "PowerHUB",
            Text = "Checking Saved Key...",
            Duration = 3,
        })
        
        -- 2. Cek ke Database Github
        local success, response = pcall(function() return game:HttpGet(KEY_DATABASE_URL) end)
        
        if success and string.find(response, savedKey) then
            -- [VALID]
            StarterGui:SetCore("SendNotification", {
                Title = "PowerHUB",
                Text = "Key Valid! Loaded.",
                Duration = 3,
            })
            
            pcall(function() loadstring(game:HttpGet(MAIN_SCRIPT_URL))() end)
            
            if ScreenGui then ScreenGui:Destroy() end
            return
        else
            -- [INVALID/EXPIRED]
            StarterGui:SetCore("SendNotification", {
                Title = "PowerHUB",
                Text = "Key Expired / Invalid.",
                Duration = 3,
            })
        end
    end
    
    -- Jika tidak ada key, munculkan UI
    ScreenGui.Enabled = true
end)

local function OpenLink(link)
    local successCopy = false
    pcall(function()
        if setclipboard then setclipboard(link) successCopy = true
        elseif toclipboard then toclipboard(link) successCopy = true end
    end)

    pcall(function() game:GetService("LinkingService"):OpenUrl(link) end)
    
    if string.find(link, "discord") and request then
        pcall(function()
            local code = string.gsub(link, "https://discord.gg/", "")
            request({
                Url = "http://127.0.0.1:6463/rpc?v=1",
                Method = "POST",
                Headers = {["Content-Type"]="application/json", ["Origin"]="https://discord.com"},
                Body = HttpService:JSONEncode({cmd="INVITE_BROWSER", args={code=code}, nonce=HttpService:GenerateGUID(false)})
            })
        end)
    end

    if successCopy then
        task.spawn(function() ShowNotification("Link Copied to Clipboard!", false) end)
    else
        task.spawn(function() ShowNotification("Opening Browser...", false) end)
    end
end

GetKeyBtn.MouseButton1Click:Connect(function()
    OpenLink(KEY_LINK)
end)

DiscordBtn.MouseButton1Click:Connect(function()
    OpenLink(DISCORD_LINK)
end)

ConfirmBtn.MouseButton1Click:Connect(function()
    local userKey = InputBox.Text
    userKey = string.gsub(userKey, "^%s*(.-)%s*$", "%1")
    
    if userKey == "" then 
        task.spawn(function() ShowNotification("Please paste the key first!", true) end)
        return 
    end
    
    ConfirmBtn.Text = "CHECKING..."
    InputBox.TextEditable = false
    
    -- Cek Database GitHub
    local success, response = pcall(function() return game:HttpGet(KEY_DATABASE_URL) end)
    
    if success then
        if string.find(response, userKey) then
            -- KEY BENAR -> SIMPAN -> MASUK
            SaveKey(userKey)
            
            task.spawn(function() ShowNotification("Access Granted! Welcome.", false) end)
            InputBox.TextColor3 = Color3.fromRGB(80, 255, 100)
            
            task.wait(1.5)
            ScreenGui:Destroy()
            
            pcall(function() loadstring(game:HttpGet(MAIN_SCRIPT_URL))() end)
        else
            task.spawn(function() ShowNotification("Invalid Key! Try again.", true) end)
            InputBox.Text = ""
            InputBox.TextEditable = true
            ConfirmBtn.Text = "CONFIRM"
        end
    else
        task.spawn(function() ShowNotification("Connection Failed!", true) end)
        InputBox.TextEditable = true
        ConfirmBtn.Text = "CONFIRM"
    end
end)

--// DRAGGABLE
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)
