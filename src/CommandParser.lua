local M = {}

local function has(text, token)
    return string.find(string.lower(text), token, 1, true) ~= nil
end

function M.parse(prompt)
    local kind = "menu"
    local platform = "desktop"
    local theme = "dark"
    local effects = {"fade"}
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
    elseif has(prompt, "claro") or has(prompt, "light") then theme = "light"
    elseif has(prompt, "medieval") then theme = "medieval" end

    if has(prompt, "celular") or has(prompt, "mobile") then platform = "mobile" end
    if has(prompt, "anim") or has(prompt, "efeito") then table.insert(effects, "pulse") end
    if has(prompt, "futur") or has(prompt, "neon") then table.insert(effects, "glow") end

    return {
        kind = kind,
        theme = theme,
        title = title,
        platform = platform,
        layout = {width = 0.72, height = 0.68},
        effects = effects,
    }
end

function M.generate(prompt, advanced)
    local parsed = M.parse(prompt)
    if advanced then
        parsed.layout = {width = 0.76, height = 0.74}
        table.insert(parsed.effects, "hover")
    end
    return {
        kind = parsed.kind,
        theme = parsed.theme,
        title = parsed.title,
        platform = parsed.platform,
        layout = parsed.layout,
        effects = parsed.effects,
        elements = {
            {type = "label", text = "Título principal"},
            {type = "button", text = "Continuar"},
            {type = "button", text = "Voltar"},
            {type = "panel", text = "Resumo do sistema"},
        },
    }
end

return M
