local M = {}
local Helper = require("config.helper")

---Returns the python binary path by looking venv directory.
---@param workspace string The workspace directory.
---@return string python_binary_path
function M.find_venv_python(workspace)
  local workspace = M.find_venv_dir(workspace)
  if workspace == "" then return "" end

  local util = require("lspconfig.util")
  local util_path = util.path
  return util_path.join(workspace, "bin", "python")
end

function M.find_venv_dir(workspace)
  -- If the virtualenv is activated,
  if vim.env.VIRTUAL_ENV then return vim.env.VIRTUAL_ENV end

  -- Check if it is a valid directory
  if workspace == "" then return "" end
  if not Helper.is_existing_dir(workspace) then workspace = vim.fs.dirname(workspace) end

  while workspace ~= nil and workspace ~= "" and workspace ~= "/" do
    local python = vim.fn.glob(workspace .. "/" .. "*/bin/python")
    if vim.fn.executable(python) == 1 then
      local venv_root = vim.fn.fnamemodify(python, ":h:h")
      return venv_root
    end

    local old_workspace = workspace
    workspace = vim.fs.dirname(workspace)

    local has_workspace_changed = old_workspace ~= workspace
    if not has_workspace_changed then return "" end
  end

  return ""
end

function M.get_python_binary(file_path)
  if not file_path or string.len(file_path) == 0 then file_path = vim.api.nvim_buf_get_name(0) end
  -- Find and use venv/python directory
  local python = M.find_venv_python(file_path)
  if python ~= "" then return python end

  -- Fallback to system Python.
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

---Returns the root of the project by looking for a virtualenv or a venv directory.
---@param file_path string A python file path.
---@return string project_root
function M.get_project_root(file_path)
  local is_dir = Helper.is_existing_dir(file_path)
  if not is_dir then file_path = vim.fs.dirname(file_path) end

  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then return vim.fs.dirname(vim.env.VIRTUAL_ENV) end

  -- search and use virtualenv
  local python = M.get_python_binary(file_path)
  if python == vim.fn.exepath("python3") or python == vim.fn.exepath("python") then return file_path end

  -- TODO: check this:
  -- it will only work if the virtualenv is named venv
  -- maybe use vim.fn.glob
  local venv_regex = "/[a-zA-Z0-9_-]*/bin/python"
  return python:gsub(venv_regex, "")
end

local function search_python_files(project_root, callback)
  local venv_root = M.find_venv_dir(project_root)
  local dirs_to_skip = {
    venv_root,
    project_root .. "/build",
  }

  local function scan_directory(directory)
    if vim.tbl_contains(dirs_to_skip, directory) then return end

    local handle = vim.loop.fs_scandir(directory)
    while handle do
      local name, type = vim.loop.fs_scandir_next(handle)
      if not name then break end
      local full_path = directory .. "/" .. name
      if type == "directory" then
        scan_directory(full_path)
      elseif name:match("%.py$") then
        callback(full_path)
      end
    end
  end
  scan_directory(project_root)
end

function M.add_python_dap_configuration(project_root)
  search_python_files(project_root, function(current_file)
    local launch_name = "Launch " .. string.gsub(current_file, "^" .. project_root .. "/", "")

    table.insert(require("dap").configurations.python, {
      type = "python",
      request = "launch",
      name = launch_name,
      program = current_file,
      console = "integratedTerminal",
    })
  end)
end

return M
