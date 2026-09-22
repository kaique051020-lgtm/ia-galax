local M = {}

local templates = {
    menu = {
        {type = "label", text = "Bem-vindo ao seu jogo"},
        {type = "button", text = "JOGAR"},
        {type = "button", text = "CONFIGURAÇÕES"},
    },
    shop = {
        {type = "label", text = "Escolha um item"},
        {type = "button", text = "ESPADA — 100 COINS"},
        {type = "button", text = "POÇÃO — 50 COINS"},
        {type = "button", text = "FECHAR"},
    },
    inventory = {
        {type = "label", text = "Seus itens"},
        {type = "button", text = "SLOT 1"},
        {type = "button", text = "SLOT 2"},
        {type = "button", text = "SLOT 3"},
    },
    hud = {
        {type = "label", text = "VIDA 100 / 100"},
        {type = "label", text = "ENERGIA 100 / 100"},
    },
    login = {
        {type = "label", text = "Entre para continuar"},
        {type = "button", text = "ENTRAR"},
        {type = "button", text = "CRIAR CONTA"},
    },
    settings = {
        {type = "label", text = "Preferências do jogo"},
        {type = "button", text = "ÁUDIO"},
        {type = "button", text = "CONTROLES"},
    },
}

function M.generate(kind, theme, platform, parsed, advanced)
    local result = {}
    for _, item in ipairs(templates[kind] or templates.menu) do
        table.insert(result, {type = item.type, text = item.text})
    end
    if advanced then
        table.insert(result, {type = "panel", text = "Layout avançado — plataforma: " .. platform})
    end
    return result
end

return M
