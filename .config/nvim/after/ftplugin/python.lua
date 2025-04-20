if vim.bo.buftype == "nofile" then
  -- HACK: see https://github.com/neovim/neovim/issues/30957
  -- The built-in commenting mechanism uses vim.filetype.get_option, which internally calls vim.api.nvim_get_option_value.
  -- This triggers the FileType autocmd once more, but only on the first invocation, as the value is cached by vim.filetype.
  -- The buffertype of this buffer is "nofile"
  return
end

-- overriding so that the project paths are correctly found?
local helper = require("config.helper.python")
vim.env.PYTHONPATH = helper.get_project_root(current_file)

-- adding my own launch configurations to dap launcher
-- The debugpy options below are from https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
