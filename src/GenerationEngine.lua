local M = {}

local Templates = require(script.Parent.Templates)
local Theme = require(script.Parent.Theme)
local CodeGenerator = require(script.Parent.CodeGenerator)
local CommandParser = require(script.Parent.CommandParser)
local Security = require(script.Parent.Security)

local function add(className, props, parent)
    local item = Instance.new(className)
    for key, value in pairs(props) do
        item[key] = value
    end
    item.Parent = parent
    return item
end

local function addCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = parent
end

local function addStroke(parent, thickness, color)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness
    stroke.Color = color
    stroke.Transparency = 0.35
    stroke.Parent = parent
end

local function addButton(parent, labelText, theme, sizeX, sizeY)
    local button = add("TextButton", {
        BackgroundColor3 = theme.accent,
        BorderSizePixel = 0,
        Size = UDim2.new(sizeX or 0.8, 0, sizeY or 0, 52),
        Text = labelText,
        TextColor3 = theme.text,
        Font = Enum.Font.GothamBold,
        TextScaled = true,
    }, parent)
    addCorner(button, 12)
    return button
end

local function addLabel(parent, text, theme, size, align)
    local label = add("TextLabel", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, size or 32),
        Text = text,
        TextColor3 = theme.muted,
        Font = Enum.Font.Gotham,
        TextSize = 16,
        TextWrapped = true,
        TextXAlignment = align or Enum.TextXAlignment.Left,
    }, parent)
    return label
end

function M.buildFromSchema(schema)
    if type(schema) ~= "table" then
        return "schema inválida"
    end

    local valid, errorMessage = Security.validateSchema(schema)
    if not valid then
        return "schema rejeitado: " .. errorMessage
    end

    local starterGui = game:GetService("StarterGui")
    local old = starterGui:FindFirstChild("GalaxGenerated")
    if old then old:Destroy() end

    local theme = Theme.get(schema.theme)
    local screen = add("ScreenGui", {
        Name = "GalaxGenerated",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
    }, starterGui)

    local root = add("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(schema.layout and schema.layout.width or 0.72, schema.layout and schema.layout.height or 0.68),
        BackgroundColor3 = theme.background,
        BorderSizePixel = 0,
    }, screen)
    addCorner(root, 18)
    addStroke(root, 2, theme.accent)

    local top = add("Frame", {
        Size = UDim2.new(1, 0, 0, 70),
        BackgroundTransparency = 1,
    }, root)

    local title = add("TextLabel", {
        BackgroundTransparency = 1,
        Size = UDim2.new(0.8, 0, 1, 0),
        Position = UDim2.new(0.06, 0, 0, 0),
        Text = schema.title,
        TextColor3 = theme.text,
        Font = Enum.Font.GothamBlack,
        TextScaled = true,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, top)

    local content = add("Frame", {
        Position = UDim2.new(0.07, 0, 0.18, 0),
        Size = UDim2.new(0.86, 0, 0.7, 0),
        BackgroundTransparency = 1,
    }, root)

    local list = add("UIListLayout", {
        Padding = UDim.new(0, 10),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, content)

    for index, element in ipairs(schema.elements or {}) do
        if element.type == "label" then
            local label = addLabel(content, element.text or "Item", theme, 28, Enum.TextXAlignment.Left)
            label.LayoutOrder = index
        elseif element.type == "button" then
            local button = addButton(content, element.text or ("Botão " .. index), theme, 0.8, 54)
            button.LayoutOrder = index
            button.TextWrapped = true
            button.Activated:Connect(function()
                button.Text = (button.Text or "") .. " ✓"
            end)
        elseif element.type == "panel" then
            local panel = add("Frame", {
                BackgroundColor3 = theme.secondary or theme.background,
                Size = UDim2.new(1, 0, 0, 90),
                BorderSizePixel = 0,
            }, content)
            addCorner(panel, 10)
            panel.LayoutOrder = index
            local text = add("TextLabel", {
                BackgroundTransparency = 1,
                Text = element.text or "Painel",
                Position = UDim2.new(0.05, 0, 0.1, 0),
                Size = UDim2.new(0.9, 0, 0.8, 0),
                TextColor3 = theme.text,
                Font = Enum.Font.Gotham,
                TextSize = 15,
                TextWrapped = true,
            }, panel)
        end
    end

    local scriptSource = CodeGenerator.build(schema)
    add("LocalScript", {
        Name = "GeneratedBehavior",
        Source = scriptSource,
    }, screen)

    return "UI gerada com sucesso"
end

function M.generate(prompt, advanced)
    local parsed = CommandParser.parse(prompt)
    if not parsed then
        return {kind = "menu", theme = "dark", title = "MENU", layout = {width = 0.72, height = 0.68}, elements = { {type = "label", text = "Interface padrão"}, {type = "button", text = "Confirmar"}}}
    end

    if advanced then
        parsed.title = parsed.title .. " AVANÇADO"
        parsed.layout = {width = 0.75, height = 0.72}
    end

    local style = Theme.get(parsed.theme)
    local schema = {
        kind = parsed.kind,
        theme = parsed.theme,
        title = parsed.title,
        platform = parsed.platform,
        layout = parsed.layout,
        effects = parsed.effects,
        elements = Templates.generate(parsed.kind, parsed.theme, parsed.platform, parsed, advanced),
        style = style,
    }

    local valid, message = Security.validateSchema(schema)
    if not valid then
        error(message)
    end

    return schema
end

return M
