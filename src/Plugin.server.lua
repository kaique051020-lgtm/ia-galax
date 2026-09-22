local toolbar = plugin:CreateToolbar("Galax AI")
local openButton = toolbar:CreateButton("GalaxAI", "Abrir Galax AI", "rbxassetid://0")
openButton.ClickableWhenViewportHidden = true

local info = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Left,
	true,
	false,
	360,
	520,
	280,
	360
)
local widget = plugin:CreateDockWidgetPluginGui("GalaxAIWidget", info)
widget.Title = "Galax AI Studio"

local modules = script.Parent:WaitForChild("GalaxModules")
local builder = require(modules.GuiBuilder)
local parser = require(modules.CommandParser)
local codeGenerator = require(modules.CodeGenerator)

local root = Instance.new("Frame")
root.Size = UDim2.fromScale(1, 1)
root.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
root.Parent = widget

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 12)
padding.PaddingBottom = UDim.new(0, 12)
padding.PaddingLeft = UDim.new(0, 12)
padding.PaddingRight = UDim.new(0, 12)
padding.Parent = root

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 8)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = root

local function label(text, height)
	local item = Instance.new("TextLabel")
	item.Size = UDim2.new(1, 0, 0, height or 28)
	item.BackgroundTransparency = 1
	item.TextColor3 = Color3.fromRGB(235, 238, 248)
	item.Font = Enum.Font.Gotham
	item.TextSize = 14
	item.TextWrapped = true
	item.TextXAlignment = Enum.TextXAlignment.Left
	item.Text = text
	item.LayoutOrder = 1
	item.Parent = root
	return item
end

label("Galax AI Studio", 30).TextSize = 20
label("Digite um comando em português. Ex.: crie uma loja neon roxa", 38)

local prompt = Instance.new("TextBox")
prompt.Name = "Prompt"
prompt.Size = UDim2.new(1, 0, 0, 72)
prompt.BackgroundColor3 = Color3.fromRGB(35, 39, 52)
prompt.TextColor3 = Color3.fromRGB(255, 255, 255)
prompt.PlaceholderText = "O que você quer criar?"
prompt.ClearTextOnFocus = false
prompt.MultiLine = true
prompt.TextWrapped = true
prompt.TextXAlignment = Enum.TextXAlignment.Left
prompt.TextYAlignment = Enum.TextYAlignment.Top
prompt.Font = Enum.Font.Gotham
prompt.TextSize = 14
prompt.LayoutOrder = 2
prompt.Parent = root

local generate = Instance.new("TextButton")
generate.Size = UDim2.new(1, 0, 0, 38)
generate.BackgroundColor3 = Color3.fromRGB(106, 74, 220)
generate.TextColor3 = Color3.new(1, 1, 1)
generate.Text = "Gerar GUI"
generate.Font = Enum.Font.GothamBold
generate.TextSize = 15
generate.LayoutOrder = 3
generate.Parent = root

local clear = Instance.new("TextButton")
clear.Size = UDim2.new(1, 0, 0, 32)
clear.BackgroundColor3 = Color3.fromRGB(55, 59, 74)
clear.TextColor3 = Color3.new(1, 1, 1)
clear.Text = "Limpar GalaxGenerated"
clear.Font = Enum.Font.Gotham
clear.TextSize = 13
clear.LayoutOrder = 4
clear.Parent = root

local status = label("Pronto. Nenhum serviço externo está conectado.", 44)
status.TextColor3 = Color3.fromRGB(164, 171, 190)
status.LayoutOrder = 5

local function run()
	local text = prompt.Text
	if text:gsub("%s", "") == "" then
		status.Text = "Digite um comando primeiro."
		return
	end
	local request = parser.parse(text)
	local ok, result = pcall(function()
		return builder.build(request)
	end)
	if ok then
		status.Text = "Criado: " .. result .. " (revise os scripts antes de publicar)."
	else
		status.Text = "Erro: " .. tostring(result)
	end
end

generate.Activated:Connect(run)
prompt.FocusLost:Connect(function(enterPressed)
	if enterPressed then run() end
end)

clear.Activated:Connect(function()
	local playerGui = game:GetService("StarterGui"):FindFirstChild("GalaxGenerated")
	if playerGui then playerGui:Destroy() end
	status.Text = "GalaxGenerated foi removido."
end)

openButton.Click:Connect(function()
	widget.Enabled = not widget.Enabled
end)

plugin.Unloading:Connect(function()
	if widget then widget:Destroy() end
end)
