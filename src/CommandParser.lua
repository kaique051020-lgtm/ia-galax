local M = {}

local function has(text, word)
	return string.find(string.lower(text), word, 1, true) ~= nil
end

function M.parse(text)
	local kind = "menu"
	if has(text, "loja") or has(text, "shop") then kind = "shop"
	elseif has(text, "invent") then kind = "inventory"
	elseif has(text, "hud") or has(text, "vida") then kind = "hud" end

	local theme = "dark"
	if has(text, "roxo") or has(text, "purple") then theme = "purple"
	elseif has(text, "neon") then theme = "neon"
	elseif has(text, "claro") then theme = "light"
	elseif has(text, "medieval") then theme = "medieval" end

	local titles = {
		menu = "MENU PRINCIPAL", shop = "LOJA", inventory = "INVENTÁRIO", hud = "HUD DO JOGADOR"
	}
	return {kind = kind, theme = theme, title = titles[kind], raw = text}
end

return M
