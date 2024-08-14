local base_path = "craftznake."
local Config = require(base_path .. "config")

return Config:init()
	:append(require(base_path .. "config.appearance"))
	:append(require(base_path .. "config.bindings"))
	:append(require(base_path .. "config.fonts"))
	:append(require(base_path .. "config.general")).options
