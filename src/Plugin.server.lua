local GenerationEngine = require(script.Parent.GenerationEngine)
local builder = require(script.Parent.GuiBuilder)

local toolbar = plugin:CreateToolbar("Galax AI")
local openButton = toolbar:CreateButton("GalaxAI", "Abrir Galax AI", "rbxassetid://0")
openButton.ClickableWhenViewportHidden = true

local info = DockWidgetPluginGuiInfo.new(
    Enum.InitialDockState.Left,
    true,
    false,
    380,
    560,
    280,
    360
)

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

local function makeLabel(text, size, color, order)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, size or 28)
    label.BackgroundTransparency = 1
    label.TextColor3 = color or Color3.fromRGB(240, 242, 250)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Text = text
    label.LayoutOrder = order or 1
    label.Parent = root
    return label
end

makeLabel("Galax AI Studio", 30, Color3.fromRGB(255,255,255), 1).TextSize = 20
makeLabel("Digite seu pedido. Ex.: loja neon roxa", 40, Color3.fromRGB(170,180,210), 2)

local input = Instance.new("TextBox")
input.Size = UDim2.new(1, 0, 0, 90)
input.BackgroundColor3 = Color3.fromRGB(30, 35, 46)
input.TextColor3 = Color3.new(1,1,1)
input.Font = Enum.Font.Gotham
input.TextSize = 14
input.MultiLine = true
input.PlaceholderText = "Descreva a GUI que você quer..."
input.TextWrapped = true
input.LayoutOrder = 3
input.Parent = root

local generate = Instance.new("TextButton")
generate.Size = UDim2.new(1, 0, 0, 42)
generate.BackgroundColor3 = Color3.fromRGB(121, 93, 248)
generate.TextColor3 = Color3.new(1,1,1)
generate.Font = Enum.Font.GothamBold
generate.TextSize = 15
generate.Text = "Gerar UI"
generate.LayoutOrder = 4
generate.Parent = root

local hard = Instance.new("TextButton")
hard.Size = UDim2.new(1, 0, 0, 34)
hard.BackgroundColor3 = Color3.fromRGB(58, 64, 80)
hard.TextColor3 = Color3.new(1,1,1)
hard.Font = Enum.Font.Gotham
hard.TextSize = 13
hard.Text = "Gerar layout avançado"
hard.LayoutOrder = 5
hard.Parent = root

local clear = Instance.new("TextButton")
clear.Size = UDim2.new(1, 0, 0, 32)
clear.BackgroundColor3 = Color3.fromRGB(39, 44, 58)
clear.TextColor3 = Color3.new(1,1,1)
clear.Font = Enum.Font.Gotham
clear.TextSize = 13
clear.Text = "Limpar resultado"
clear.LayoutOrder = 6
clear.Parent = root

local status = makeLabel("Pronto. Sistema local ativo.", 52, Color3.fromRGB(175,182,200), 7)
status.TextWrapped = true

local function handleGenerate(useAdvanced)
    local prompt = input.Text
    if string.len(prompt:gsub("%s", "")) == 0 then
        status.Text = "Digite um pedido primeiro."
        return
    end

    local ok, schema = pcall(function()
        return GenerationEngine.generate(prompt, useAdvanced)
    end)

    if not ok then
        status.Text = "Erro: " .. tostring(schema)
        return
    end

    local success, result = pcall(function()
        return builder.buildFromSchema(schema)
    end)

    if success then
        status.Text = "Criação concluída: " .. result
    else
        status.Text = "Falha ao construir a UI: " .. tostring(result)
    end
end

generate.Activated:Connect(function() handleGenerate(false) end)
hard.Activated:Connect(function() handleGenerate(true) end)

clear.Activated:Connect(function()
    local s = game:GetService("StarterGui"):FindFirstChild("GalaxGenerated")
    if s then s:Destroy() end
    status.Text = "Resultado limpo."
end)

openButton.Click:Connect(function()
    widget.Enabled = not widget.Enabled
end)

plugin.Unloading:Connect(function()
    if widget then widget:Destroy() end
end)
