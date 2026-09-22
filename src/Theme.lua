local M = {}
local themes = {
	dark = {background = Color3.fromRGB(25, 28, 38), accent = Color3.fromRGB(106, 74, 220), text = Color3.new(1, 1, 1), muted = Color3.fromRGB(190, 195, 212)},
	purple = {background = Color3.fromRGB(34, 22, 54), accent = Color3.fromRGB(190, 80, 255), text = Color3.new(1, 1, 1), muted = Color3.fromRGB(220, 180, 245)},
	neon = {background = Color3.fromRGB(10, 28, 32), accent = Color3.fromRGB(0, 245, 190), text = Color3.fromRGB(230, 255, 250), muted = Color3.fromRGB(150, 230, 220)},
	light = {background = Color3.fromRGB(235, 238, 246), accent = Color3.fromRGB(50, 100, 220), text = Color3.fromRGB(20, 25, 38), muted = Color3.fromRGB(80, 86, 105)},
	medieval = {background = Color3.fromRGB(55, 37, 25), accent = Color3.fromRGB(210, 150, 55), text = Color3.fromRGB(255, 240, 190), muted = Color3.fromRGB(220, 190, 140)},
}
function M.get(name) return themes[name] or themes.dark end
return M
