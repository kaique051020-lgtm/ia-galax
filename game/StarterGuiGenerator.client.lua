-- Galax AI - versão simples para testar dentro do jogo
-- Coloque este LocalScript em StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "GalaxDemo"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local frame = Instance.new("Frame")
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.fromScale(0.5, 0.5)
frame.Size = UDim2.fromScale(0.38, 0.42)
frame.BackgroundColor3 = Color3.fromRGB(25, 22, 38)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(190, 80, 255)
stroke.Thickness = 2
stroke.Parent = frame

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromScale(0.08, 0.08)
title.Size = UDim2.fromScale(0.84, 0.18)
title.Text = "MENU GALAX AI"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.Parent = frame

local message = Instance.new("TextLabel")
message.BackgroundTransparency = 1
message.Position = UDim2.fromScale(0.1, 0.3)
message.Size = UDim2.fromScale(0.8, 0.12)
message.Text = "Esta GUI foi criada por um script."
message.TextColor3 = Color3.fromRGB(205, 190, 220)
message.Font = Enum.Font.Gotham
message.TextScaled = true
message.Parent = frame

local play = Instance.new("TextButton")
play.Position = UDim2.fromScale(0.15, 0.5)
play.Size = UDim2.fromScale(0.7, 0.16)
play.Text = "JOGAR"
play.TextColor3 = Color3.fromRGB(255, 255, 255)
play.BackgroundColor3 = Color3.fromRGB(150, 70, 230)
play.Font = Enum.Font.GothamBold
play.TextScaled = true
play.Parent = frame

local playCorner = Instance.new("UICorner")
playCorner.CornerRadius = UDim.new(0, 10)
playCorner.Parent = play

local close = Instance.new("TextButton")
close.Position = UDim2.fromScale(0.15, 0.7)
close.Size = UDim2.fromScale(0.7, 0.13)
close.Text = "FECHAR"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.BackgroundColor3 = Color3.fromRGB(65, 60, 78)
close.Font = Enum.Font.GothamBold
close.TextScaled = true
close.Parent = frame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = close

play.Activated:Connect(function()
	message.Text = "Você clicou em JOGAR!"
end)

close.Activated:Connect(function()
	gui:Destroy()
end)
