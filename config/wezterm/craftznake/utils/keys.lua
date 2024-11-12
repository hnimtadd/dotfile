local base_path = "craftznake."
local platform = require(base_path .. "utils.platform")()

local mods = setmetatable({
	_SHORT_MOD_MAP = {
		_ = "NONE",
		C = "CTRL",
		S = "SHIFT",
		A = "ALT",
		L = "LEADER",
		D = platform.is_mac and "CMD" or "ALT", -- D for Desktop (Win/Cmd/Super)
	},
}, {
	-- Dynamically transform key access of 'CSA' to 'CTRL|SHIFT|ALT'
	__index = function(self, key)
		local char = key:sub(1, 1)
		local resolved_mods = self._SHORT_MOD_MAP[char] or char
		for i = 2, #key do
			char = key:sub(i, i)
			resolved_mods = resolved_mods .. "|" .. (self._SHORT_MOD_MAP[char] or char)
		end
		return resolved_mods
	end,
})

local function keyset(key_mods, keys, action)
	local local_keys = (type(keys) == "table") and keys or { keys }
	local local_mods = key_mods
	local local_binds = {}
	for _, key in ipairs(local_keys) do
		table.insert(local_binds, { mods = local_mods, key = key, action = action })
	end
	return local_binds
end

return {
	mods = mods,
	keyset = keyset,
}
