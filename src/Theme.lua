local M = {}
local themes = {
    dark = {background = Color3.fromRGB(20,23,31), secondary = Color3.fromRGB(28,34,46), accent = Color3.fromRGB(123,92,255), text = Color3.fromRGB(240,241,245), muted = Color3.fromRGB(180,186,205)},
    purple = {background = Color3.fromRGB(36,22,52), secondary = Color3.fromRGB(57,39,80), accent = Color3.fromRGB(196,97,255), text = Color3.new(1,1,1), muted = Color3.fromRGB(230,205,250)},
    neon = {background = Color3.fromRGB(12,25,30), secondary = Color3.fromRGB(17,39,45), accent = Color3.fromRGB(0,240,200), text = Color3.fromRGB(230,255,250), muted = Color3.fromRGB(165,220,220)},
    light = {background = Color3.fromRGB(238,242,248), secondary = Color3.fromRGB(220,228,241), accent = Color3.fromRGB(67,108,255), text = Color3.fromRGB(13,17,27), muted = Color3.fromRGB(77,91,112)},
    medieval = {background = Color3.fromRGB(52,37,23), secondary = Color3.fromRGB(79,54,34), accent = Color3.fromRGB(212,158,77), text = Color3.fromRGB(255,234,190), muted = Color3.fromRGB(235,206,160)},
}
function M.get(name) return themes[name] or themes.dark end
return M
