local M = {}

function M.buttonScript(kind)
	return [[local gui = script.Parent
-- Comportamentos avançados podem ser adicionados com segurança aqui.
-- Este arquivo não carrega código remoto nem require IDs desconhecidos.
for _, object in ipairs(gui:GetDescendants()) do
	if object:IsA("TextButton") then
		object.Activated:Connect(function()
			print("Galax AI: botão ativado", object.Name)
		end)
	end
end
]]
end

return M
