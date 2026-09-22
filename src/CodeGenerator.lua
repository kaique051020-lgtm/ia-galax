local M = {}
function M.build(schema)
    return [[local gui = script.Parent
for _, object in ipairs(gui:GetDescendants()) do
    if object:IsA("TextButton") then
        object.Activated:Connect(function()
            print("Galax AI: botão ativado", object.Name)
        end)
    end
end]]
end
return M
