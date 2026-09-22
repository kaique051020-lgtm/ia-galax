local M = {}

local function has(input, token)
    return string.find(string.lower(input), token, 1, true) ~= nil
end

function M.parse(prompt)
    if type(prompt) ~= "string" or string.len(prompt:gsub("%s", "")) == 0 then
        return nil
    end

    local kind = "menu"
    local theme = "dark"
    local platform = "desktop"
    local title = "MENU PRINCIPAL"

    if has(prompt, "loja") or has(prompt, "shop") then
        kind = "shop"
        title = "LOJA"
    elseif has(prompt, "invent") then
        kind = "inventory"
        title = "INVENTÁRIO"
    elseif has(prompt, "hud") or has(prompt, "vida") or has(prompt, "status") then
        kind = "hud"
        title = "HUD"
    elseif has(prompt, "login") or has(prompt, "entrar") then
        kind = "login"
        title = "LOGIN"
    elseif has(prompt, "config") then
        kind = "settings"
        title = "CONFIGURAÇÕES"
    end

    if has(prompt, "roxo") or has(prompt, "purple") then theme = "purple"
    elseif has(prompt, "neon") then theme = "neon"
    elseif has(prompt, "light") or has(prompt, "claro") then theme = "light"
    elseif has(prompt, "medieval") then theme = "medieval" end

    if has(prompt, "celular") or has(prompt, "mobile") or has(prompt, "phone") then platform = "mobile" end

    return {
        kind = kind,
        theme = theme,
        title = title,
        platform = platform,
        layout = {width = 0.72, height = 0.68},
        effects = {"fade"},
    }
end

return M
