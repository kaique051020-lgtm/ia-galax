local M = {}
local function has(text, token) return string.find(string.lower(text), token, 1, true) ~= nil end
function M.parse(prompt)
    if type(prompt) ~= "string" or prompt:gsub("%s", "") == "" then return nil end
    local kind, title = "menu", "MENU PRINCIPAL"
    if has(prompt,"loja") or has(prompt,"shop") then kind,title="shop","LOJA"
    elseif has(prompt,"invent") then kind,title="inventory","INVENTÁRIO"
    elseif has(prompt,"hud") or has(prompt,"vida") or has(prompt,"status") then kind,title="hud","HUD"
    elseif has(prompt,"login") or has(prompt,"entrar") then kind,title="login","LOGIN"
    elseif has(prompt,"config") then kind,title="settings","CONFIGURAÇÕES" end
    local theme = "dark"
    if has(prompt,"roxo") or has(prompt,"purple") then theme="purple"
    elseif has(prompt,"neon") then theme="neon"
    elseif has(prompt,"claro") or has(prompt,"light") then theme="light"
    elseif has(prompt,"medieval") then theme="medieval" end
    local platform = (has(prompt,"celular") or has(prompt,"mobile") or has(prompt,"phone")) and "mobile" or "desktop"
    local effects = {"fade"}
    if has(prompt,"anim") or has(prompt,"efeito") then table.insert(effects,"pulse") end
    return {kind=kind, theme=theme, title=title, platform=platform, effects=effects}
end
return M
