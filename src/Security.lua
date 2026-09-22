local M = {}

function M.validateGeneratedText(text)
	if type(text) ~= "string" or #text > 200000 then return false, "resposta inválida" end
	local forbidden = {"loadstring", "getfenv", "setfenv", "HttpGet", "require("}
	for _, token in ipairs(forbidden) do
		if string.find(text, token, 1, true) then return false, "token bloqueado: " .. token end
	end
	return true
end

return M
