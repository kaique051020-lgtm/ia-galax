local M = {}
local allowedKinds = {menu=true, shop=true, inventory=true, hud=true, login=true, settings=true}
local allowedThemes = {dark=true, purple=true, neon=true, light=true, medieval=true}
local allowedElements = {label=true, button=true, panel=true}
function M.validateSchema(schema)
    if type(schema) ~= "table" then return false, "schema inválida" end
    if type(schema.title) ~= "string" or #schema.title > 80 then return false, "título inválido" end
    if not allowedKinds[schema.kind] then return false, "tipo inválido" end
    if not allowedThemes[schema.theme] then return false, "tema inválido" end
    if type(schema.elements) ~= "table" or #schema.elements > 40 then return false, "elementos inválidos" end
    for _, item in ipairs(schema.elements) do
        if type(item) ~= "table" or not allowedElements[item.type] then return false, "elemento não permitido" end
        if item.text ~= nil and (type(item.text) ~= "string" or #item.text > 200) then return false, "texto inválido" end
    end
    return true
end
return M
