local M = {}
local Theme = require(script.Parent:WaitForChild("Theme"))
local Security = require(script.Parent:WaitForChild("Security"))
local CodeGenerator = require(script.Parent:WaitForChild("CodeGenerator"))
local function add(className, props, parent)
    local item = Instance.new(className)
    for key,value in pairs(props) do item[key]=value end
    item.Parent=parent
    return item
end
local function corner(parent, radius) add("UICorner", {CornerRadius=UDim.new(0,radius)}, parent) end
function M.buildFromSchema(schema)
    local valid, reason = Security.validateSchema(schema)
    if not valid then return "schema rejeitado: "..reason end
    local starterGui = game:GetService("StarterGui")
    local old = starterGui:FindFirstChild("GalaxGenerated")
    if old then old:Destroy() end
    local theme = Theme.get(schema.theme)
    local screen = add("ScreenGui", {Name="GalaxGenerated", ResetOnSpawn=false, IgnoreGuiInset=true}, starterGui)
    local root = add("Frame", {AnchorPoint=Vector2.new(.5,.5), Position=UDim2.fromScale(.5,.5), Size=UDim2.fromScale(schema.layout.width,schema.layout.height), BackgroundColor3=theme.background, BorderSizePixel=0}, screen)
    corner(root,18)
    add("UIStroke", {Color=theme.accent, Thickness=2, Transparency=.3}, root)
    local top = add("Frame", {Size=UDim2.new(1,0,0,70), BackgroundTransparency=1}, root)
    add("TextLabel", {BackgroundTransparency=1, Position=UDim2.new(.06,0,0,0), Size=UDim2.new(.88,0,1,0), Text=schema.title, TextColor3=theme.text, Font=Enum.Font.GothamBlack, TextScaled=true, TextXAlignment=Enum.TextXAlignment.Left}, top)
    local content = add("Frame", {Position=UDim2.new(.07,0,.18,0), Size=UDim2.new(.86,0,.7,0), BackgroundTransparency=1}, root)
    add("UIListLayout", {Padding=UDim.new(0,10), HorizontalAlignment=Enum.HorizontalAlignment.Center, SortOrder=Enum.SortOrder.LayoutOrder}, content)
    for index,element in ipairs(schema.elements) do
        if element.type == "label" then
            add("TextLabel", {LayoutOrder=index, Size=UDim2.new(1,0,0,32), BackgroundTransparency=1, Text=element.text, TextColor3=theme.muted, Font=Enum.Font.Gotham, TextSize=16, TextWrapped=true}, content)
        elseif element.type == "button" then
            local b=add("TextButton", {LayoutOrder=index, Size=UDim2.new(.8,0,0,52), BackgroundColor3=theme.accent, BorderSizePixel=0, Text=element.text, TextColor3=theme.text, Font=Enum.Font.GothamBold, TextScaled=true}, content)
            corner(b,12)
            b.Activated:Connect(function() b.Text=element.text.." ✓" end)
        elseif element.type == "panel" then
            local p=add("Frame", {LayoutOrder=index, Size=UDim2.new(1,0,0,72), BackgroundColor3=theme.secondary, BorderSizePixel=0}, content)
            corner(p,10)
            add("TextLabel", {BackgroundTransparency=1, Position=UDim2.new(.05,0,.1,0), Size=UDim2.new(.9,0,.8,0), Text=element.text, TextColor3=theme.text, Font=Enum.Font.Gotham, TextSize=15, TextWrapped=true}, p)
        end
    end
    add("LocalScript", {Name="GeneratedBehavior", Source=CodeGenerator.build(schema)}, screen)
    return "UI criada em StarterGui > GalaxGenerated"
end
return M
