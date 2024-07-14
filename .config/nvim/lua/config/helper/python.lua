local M = {}
local Helper = require("config.helper")

function M.search_venv_python(workspace)
  if workspace == "" then return "" end

  if not Helper.is_existing_dir(workspace) then workspace = vim.fs.dirname(workspace) end

  -- Use activated virtublenv.
  if vim.env.VIRTUAL_ENV then
    local util = require("lspconfig.util")
    local util_path = util.path
    return util_path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  while workspace ~= nil and workspace ~= "" and workspace ~= "/" do
    local python = vim.fn.glob(workspace .. "/" .. "*/bin/python")
    if vim.fn.executable(python) == 1 then return python end

    workspace = vim.fs.dirname(workspace)
  end

  return ""
end

function M.get_python_path(file_path)
  if not file_path or string.len(file_path) == 0 then file_path = vim.api.nvim_buf_get_name(0) end
  -- Find and use venv/python directory
  local python = M.search_venv_python(file_path)
  if python ~= "" then return python end

  -- Fallback to system Python.
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

function M.get_py_root(file_path)
  local is_dir = Helper.is_existing_dir(file_path)
  if not is_dir then file_path = vim.fs.dirname(file_path) end

  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then return vim.fs.dirname(vim.env.VIRTUAL_ENV) end

  -- search and use virtualenv
  local python = M.get_python_path(file_path)
  if python == vim.fn.exepath("python3") or python == vim.fn.exepath("python") then return file_path end

  -- TODO: check this:
  -- it will only work if the virtualenv is named venv
  -- maybe use vim.fn.glob
  local venv_regex = "/[a-zA-Z0-9_-]*/bin/python"
  return python:gsub(venv_regex, "")
end

return M
