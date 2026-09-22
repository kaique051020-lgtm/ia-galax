local Templates = require(script.Parent.Templates)
local Theme = require(script.Parent.Theme)
local CodeGenerator = require(script.Parent.CodeGenerator)

local M = {}

local function add(className, props, parent)
	local item = Instance.new(className)
	for key, value in pairs(props) do item[key] = value end
	item.Parent = parent
	return item
end

local function styleButton(button, theme)
	button.BackgroundColor3 = theme.accent
	button.TextColor3 = theme.text
	button.Font = Enum.Font.GothamBold
	button.TextSize = 16
	add("UICorner", {CornerRadius = UDim.new(0, 10)}, button)
end

function M.build(request)
	local starterGui = game:GetService("StarterGui")
	local old = starterGui:FindFirstChild("GalaxGenerated")
	if old then old:Destroy() end

	local theme = Theme.get(request.theme)
	local screen = add("ScreenGui", {
		Name = "GalaxGenerated",
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
	}, starterGui)
	local frame = add("Frame", {
		Name = "MainFrame",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(0.72, 0.68),
		BackgroundColor3 = theme.background,
	}, screen)
	add("UICorner", {CornerRadius = UDim.new(0, 16)}, frame)
	add("UIStroke", {Color = theme.accent, Thickness = 2, Transparency = 0.25}, frame)
	add("UIAspectRatioConstraint", {AspectRatio = 1.5, AspectType = Enum.AspectType.FitWithinMaxSize}, frame)

	local title = add("TextLabel", {
		Name = "Title",
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.06, 0.06),
		Size = UDim2.fromScale(0.88, 0.14),
		Text = request.title,
		TextColor3 = theme.text,
		Font = Enum.Font.GothamBlack,
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, frame)

	local content = add("Frame", {
		Name = "Content",
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.08, 0.25),
		Size = UDim2.fromScale(0.84, 0.68),
	}, frame)
	add("UIListLayout", {Padding = UDim.new(0, 10), HorizontalAlignment = Enum.HorizontalAlignment.Center}, content)

	for _, item in ipairs(Templates[request.kind] or Templates.menu) do
		if item.type == "label" then
			add("TextLabel", {
				Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1,
				Text = item.text, TextColor3 = theme.muted, Font = Enum.Font.Gotham,
				TextSize = 16, TextWrapped = true,
			}, content)
		elseif item.type == "button" then
			local button = add("TextButton", {
				Size = UDim2.new(0.82, 0, 0, 48), Text = item.text,
			}, content)
			styleButton(button, theme)
			button.Activated:Connect(function()
				button.Text = item.text .. " ✓"
			end)
		end
	end

	local scriptSource = CodeGenerator.buttonScript(request.kind)
	local behavior = add("LocalScript", {Name = "GeneratedBehavior", Source = scriptSource}, screen)
	return request.kind .. " com " .. tostring(#content:GetChildren()) .. " elementos"
end

return M
