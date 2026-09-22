local GenerationEngine = require(script.Parent:WaitForChild("GenerationEngine"))
local builder = require(script.Parent:WaitForChild("GuiBuilder"))

local toolbar = plugin:CreateToolbar("Galax AI")
local openButton = toolbar:CreateButton("GalaxAI", "Abrir Galax AI", "rbxassetid://0")
openButton.ClickableWhenViewportHidden = true

local info = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Left, true, false, 380, 560, 280, 360)
local widget = plugin:CreateDockWidgetPluginGui("GalaxAIWidget", info)
widget.Title = "Galax AI Studio"

local root = Instance.new("Frame")
root.Size = UDim2.fromScale(1, 1)
root.BackgroundColor3 = Color3.fromRGB(17, 20, 26)
root.Parent = widget

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 12)
padding.PaddingBottom = UDim.new(0, 12)
padding.PaddingLeft = UDim.new(0, 12)
padding.PaddingRight = UDim.new(0, 12)
padding.Parent = root

local list = Instance.new("UIListLayout")
list.Padding = UDim.new(0, 10)
list.SortOrder = Enum.SortOrder.LayoutOrder
list.Parent = root

local function label(text, height, order)
    local item = Instance.new("TextLabel")
    item.Size = UDim2.new(1, 0, 0, height or 28)
    item.BackgroundTransparency = 1
    item.TextColor3 = Color3.fromRGB(235, 238, 248)
    item.Font = Enum.Font.Gotham
    item.TextSize = 14
    item.TextWrapped = true
    item.TextXAlignment = Enum.TextXAlignment.Left
    item.Text = text
    item.LayoutOrder = order
    item.Parent = root
    return item
end

local title = label("Galax AI Studio", 30, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
label("Descreva a interface que você quer criar.", 36, 2)

local input = Instance.new("TextBox")
input.Size = UDim2.new(1, 0, 0, 90)
input.BackgroundColor3 = Color3.fromRGB(30, 35, 46)
input.TextColor3 = Color3.new(1, 1, 1)
input.PlaceholderText = "Ex.: crie uma loja neon roxa"
input.ClearTextOnFocus = false
input.MultiLine = true
input.TextWrapped = true
input.TextXAlignment = Enum.TextXAlignment.Left
input.TextYAlignment = Enum.TextYAlignment.Top
input.Font = Enum.Font.Gotham
input.TextSize = 14
input.LayoutOrder = 3
input.Parent = root

local function button(text, color, order)
    local item = Instance.new("TextButton")
    item.Size = UDim2.new(1, 0, 0, 40)
    item.BackgroundColor3 = color
    item.TextColor3 = Color3.new(1, 1, 1)
    item.Font = Enum.Font.GothamBold
    item.TextSize = 14
    item.Text = text
    item.LayoutOrder = order
    item.Parent = root
    return item
end

local generate = button("Gerar UI", Color3.fromRGB(121, 93, 248), 4)
local advanced = button("Gerar layout avançado", Color3.fromRGB(58, 64, 80), 5)
local clear = button("Limpar resultado", Color3.fromRGB(39, 44, 58), 6)
local status = label("Pronto. Esta versão funciona sem internet.", 52, 7)
status.TextColor3 = Color3.fromRGB(175, 182, 200)

local function generateUi(isAdvanced)
    local prompt = input.Text
    if prompt:gsub("%s", "") == "" then
        status.Text = "Digite um pedido primeiro."
        return
    end

    local ok, schema = pcall(GenerationEngine.generate, prompt, isAdvanced)
    if not ok then
        status.Text = "Erro ao interpretar: " .. tostring(schema)
        return
    end

    local built, message = pcall(builder.buildFromSchema, schema)
    status.Text = built and ("Pronto: " .. tostring(message)) or ("Erro ao criar: " .. tostring(message))
end

generate.Activated:Connect(function() generateUi(false) end)
advanced.Activated:Connect(function() generateUi(true) end)
clear.Activated:Connect(function()
    local generated = game:GetService("StarterGui"):FindFirstChild("GalaxGenerated")
    if generated then generated:Destroy() end
    status.Text = "Resultado removido."
end)
openButton.Click:Connect(function() widget.Enabled = not widget.Enabled end)
plugin.Unloading:Connect(function() widget:Destroy() end)
