if vim.bo.buftype == "nofile" then
  -- HACK: see https://github.com/neovim/neovim/issues/30957
  -- The built-in commenting mechanism uses vim.filetype.get_option, which internally calls vim.api.nvim_get_option_value.
  -- This triggers the FileType autocmd once more, but only on the first invocation, as the value is cached by vim.filetype.
  -- The buffertype of this buffer is "nofile"
  return
end

local helper = require("config.helper.python")
local status_ok, py_dap = pcall(require, "dap-python")
local debug_server = os.getenv("HOME") .. "/dev/microsoft/debugpy/bin/python"

if not status_ok then return end

local current_file = vim.api.nvim_buf_get_name(0)

-- overriding so that the project paths are correctly found?
vim.env.PYTHONPATH = helper.get_py_root(current_file)

-- dynamically determine the python path
py_dap.resolve_python = function() return helper.get_python_path(current_file) end

py_dap.setup(debug_server, {
  justMyCode = false,
  include_configs = true,
})

-- adding my own launch configurations to dap launcher
-- The debugpy options below are from https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
table.insert(require("dap").configurations.python, {
  type = "python",
  request = "launch",
  name = "Launch project main.py",
  program = "main.py",
  console = "integratedTerminal",
})
