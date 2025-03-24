local M = {}

-- Function to create a window in new tab
local function create_new_tab()
  local buf = vim.api.nvim_create_buf(false, true)

  -- Open a new window at new tab
  vim.cmd("tabnew")

  -- Get the new window in new tab
  local new_win = vim.api.nvim_get_current_win()
  -- Set the buffer in the new window
  vim.api.nvim_win_set_buf(new_win, buf)

  -- Set window options
  local win_opts = {
    number = false, -- No line numbers
    relativenumber = false, -- No relative numbers
    wrap = false, -- No line wrapping
    signcolumn = "no", -- No sign column
    foldcolumn = "0", -- No fold column
    spell = false, -- No spell checking
    list = false, -- No list chars
  }

  -- Set window options like current window
  for key, value in pairs(win_opts) do
    vim.api.nvim_set_option_value(key, value, { win = new_win })
  end
  -- Set tab label

  return buf, new_win
end

-- Fetch Go documentation
local function fetch_godoc(query)
  local handle = io.popen("go doc -src " .. query)
  if handle then
    local result = handle:read("*a")
    handle:close()
    if result == nil or result == "" then
      vim.notify("No documentation found for: " .. query, vim.log.levels.WARN)
      return ""
    end
    return result
  else
    return "Error: Failed to fetch documentation."
  end
end

-- Show documentation in floating window
function M.show_doc(query)
  if query == nil or query == "" then
    vim.notify("Usage: :GoDoc <package> <symbol>?", vim.log.levels.ERROR)
    return
  end

  local buf, _ = create_new_tab()
  local doc_text = fetch_godoc(query)

  if doc_text == nil or doc_text == "" then
    vim.notify("No documentation found for: " .. query, vim.log.levels.WARN)
    return
  end
  -- Set the buffer content
  local lines = vim.split(doc_text, "\n")
  -- Make buffer modifiable before setting lines
  vim.api.nvim_set_option_value("modifiable", true, { buf = buf })
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Set keybind to close with `q`
  vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
  vim.api.nvim_set_option_value("filetype", "go", { buf = buf }) -- Set filetype for syntax highlighting
  vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
end

-- -- [[
--   Entry have type:
--   package_name: [
--     {
--       name: string,
--       type: string,
--     }
--   ]
-- ]]

local symbol_cache = {}

local function get_package_symbols(package)
  -- Check cache first
  if symbol_cache[package] then
    return symbol_cache[package]
  end

  local cmd = string.format("go doc -short %s", package)
  local handle = io.popen(cmd)
  if not handle then
    return {}
  end
  local result = handle:read("*a")
  handle:close()

  local symbols = {}

  for line in result:gmatch("[^\r\n]+") do
    local symbol_type, symbol_name = line:match("^(%w+)%s+([%w_]+)")
    if symbol_name then
      table.insert(symbols, {
        name = symbol_name,
        type = symbol_type,
      })
    end
  end
  -- Cache the symbols
  symbol_cache[package] = symbols
  return symbols
end

-- Get available Go packages for autocomplete
local function get_go_packages()
  local handle = io.popen("go list std")
  if not handle then
    return {}
  end

  local result = handle:read("*a")
  handle:close()

  local packages = {}
  for line in result:gmatch("[^\r\n]+") do
    table.insert(packages, line)
  end
  return packages
end

-- Auto-complete function
local function godoc_complete(_, CmdLine, _)
  -- Split command line by space and remove the first element (command name)
  local parts = vim.split(CmdLine, " ", { trimempty = true })
  table.remove(parts, 1) -- Remove the first element (the command name "GoDoc")

  -- If no parts, return all packages
  if #parts == 0 or CmdLine == "" then
    return get_go_packages()
  end

  -- If one part and no trailing space, complete package
  if #parts == 1 and not CmdLine:match("%s$") then
    local matches = {}
    local package_prefix = parts[1]
    local entries = get_go_packages()
    for _, pkg in ipairs(entries) do
      if pkg:match("^" .. vim.pesc(package_prefix)) then
        table.insert(matches, pkg)
      end
    end
    return matches
  end

  -- If we have a complete package name, and a space after it or we're starting to type a symbol
  local pkg = parts[1]
  local symbol_prefix = ""
  if #parts > 1 then
    symbol_prefix = parts[2]
  end

  local matches = {}
  local entries = get_package_symbols(pkg)
  for _, entry in ipairs(entries) do
    if entry.name:match("^" .. vim.pesc(symbol_prefix)) then
      table.insert(matches, entry.name)
    end
  end
  return matches
end

function M.setup()
  -- Create the `:GoDoc` command with autocomplete
  vim.api.nvim_create_user_command("GoDoc", function(opts)
    M.show_doc(opts.args)
  end, {
    nargs = "+",
    complete = godoc_complete,
    desc = "Fetch documentation from go doc",
  })
end

return M
