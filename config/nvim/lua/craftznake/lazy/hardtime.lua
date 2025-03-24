return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {},
  config = function()
    local hardtime = require("hardtime")
    local cache = require("craftznake.lazy.utils.cache")
    local CACHE_NAMESPACE = "hardtime"

    local function get_cache_state()
      local project_key = cache.get_project_key()
      return cache.get_cached_value(CACHE_NAMESPACE, project_key, true)
    end

    local function save_cache_state(disabled)
      local project_key = cache.get_project_key()
      cache.save_value(CACHE_NAMESPACE, project_key, disabled)
    end

    local hardtime_disabled = get_cache_state()
    local original_hardtime_toggle = hardtime.toggle

    hardtime.toggle = function()
      original_hardtime_toggle()
      save_cache_state(hardtime.is_plugin_enabled)
      vim.notify("hardtime: " .. tostring(hardtime.is_plugin_enabled), vim.log.levels.INFO)
    end
    hardtime.setup({
      enabled = hardtime_disabled,
    })
  end,
}
