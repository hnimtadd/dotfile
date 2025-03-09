local function string_to_hex(str)
    local hash = 0
    for i = 1, #str do
        hash = (hash * 31 + str:byte(i)) % 0xFFFFFF
    end
    -- Extract RGB components
    local r = (hash >> 16) & 0xFF
    local g = (hash >> 8) & 0xFF
    local b = hash & 0xFF

    -- Return hex color string
    return string.format("#%02X%02X%02X", r, g, b)
end

local function hex_to_rgb(hex)
    hex = hex:gsub("#", "") -- Remove #
    local r = tonumber(hex:sub(1, 2), 16)
    local g = tonumber(hex:sub(3, 4), 16)
    local b = tonumber(hex:sub(5, 6), 16)
    return r, g, b
end

local function get_contrast_color(bg_hex)
    local r, g, b = hex_to_rgb(bg_hex)
    -- Calculate luminance
    local luminance = (0.299 * r + 0.587 * g + 0.114 * b)
    -- Return black for bright backgrounds, white for dark backgrounds
    return (luminance > 128) and "#000000" or "#FFFFFF"
end

return {
	string_to_hex = string_to_hex,
	get_contrast_color = get_contrast_color,
}
