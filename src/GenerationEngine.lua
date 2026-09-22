local M = {}
local Parser = require(script.Parent:WaitForChild("CommandParser"))
local Templates = require(script.Parent:WaitForChild("Templates"))
local Theme = require(script.Parent:WaitForChild("Theme"))
local Security = require(script.Parent:WaitForChild("Security"))

function M.generate(prompt, advanced)
    local parsed = Parser.parse(prompt)
    if not parsed then error("prompt vazio") end
    local schema = {
        kind = parsed.kind,
        theme = parsed.theme,
        title = parsed.title,
        platform = parsed.platform,
        layout = advanced and {width=0.76, height=0.74} or {width=0.72, height=0.68},
        effects = parsed.effects,
        elements = Templates.generate(parsed.kind, parsed.theme, parsed.platform, parsed, advanced),
        style = Theme.get(parsed.theme),
    }
    local valid, reason = Security.validateSchema(schema)
    if not valid then error(reason) end
    return schema
end
return M
