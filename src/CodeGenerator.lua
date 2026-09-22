local M = {}

local forbidden = {
    "loadstring",
    "getfenv",
    "setfenv",
    "HttpGet",
    "HttpPost",
    "debug",
    "synapse",
    "require(%s*%(%s*%d",
    "load(%s*%(",
}

function M.validateSchema(schema)
    if type(schema) ~= "table" then
        return false, "schema não é tabela"
    end

    if type(schema.title) ~= "string" or #schema.title > 80 then
        return false, "título inválido"
    end

    if type(schema.theme) ~= "string" then
        return false, "tema inválido"
    end

    if type(schema.elements) ~= "table" then
        return false, "lista de elementos inválida"
    end

    for _, item in ipairs(schema.elements) do
        if type(item.type) ~= "string" then
            return false, "elemento sem tipo"
        end
        if item.text and type(item.text) == "string" and #item.text > 200 then
            return false, "texto excessivo"
        end
    end

    for _, token in ipairs(forbidden) do
        local serialized = tostring(schema)
        if string.find(serialized, token, 1, true) then
            return false, "token proibido detectado"
        end
    end

    return true
end

return M
