local M = {}

function M.is_existing_dir(path) return vim.fn.isdirectory(path) == 1 end

---@param path string
---@return string
function M.read_file(path)
  local fd = assert(vim.uv.fs_open(path, "r", 438))
  local stat = assert(vim.uv.fs_fstat(fd))
  local data = assert(vim.uv.fs_read(fd, stat.size, 0))
  assert(vim.uv.fs_close(fd))
  return data
end

function M.has_value(table, element)
  if type(table) ~= "table" then return false end

  for _, value in pairs(table) do
    if value == element then return true end
  end
  return false
end

function M.is_empty(table) return next(table) == nil end

function M.cmd_to_table(cmd)
  local temp_table = {}
  local pipe = io.popen(cmd)
  if pipe == nil then return temp_table end

  for line in pipe:lines() do
    table.insert(temp_table, line)
  end
  pipe:close()

  return temp_table
end

---@return string
function M.find_root(fname)
  local path = fname
  ---@type string[]
  local roots = {}
  local root_patterns = require("config.globals").root_patterns

  if path ~= "" then
    for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws) return vim.uri_to_fname(ws.uri) end, workspace)
        or client.config.root_dir and { client.config.root_dir }
        or {}
      for _, p in ipairs(paths) do
        local r = vim.uv.fs_realpath(p)
        if path:find(r, 1, true) then roots[#roots + 1] = r end
      end
    end
  end

  ---@type string?
  local root = roots[1]
  if not root then
    local should_run = true
    path = path == "" and vim.loop.cwd() or vim.fs.dirname(path)

    while should_run do
      root = vim.fs.find(root_patterns, { path = path, upward = true })[1]
      path = vim.fs.dirname(path)

      if root ~= nil or path == "/" then should_run = false end
    end
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  ---@cast root string
  return root
end

function M.get_module(fname)
  -- action if its lua file
  local nvim_path = "nvim/lua"
  if string.find(fname, "lua") and string.find(fname, nvim_path) then
    fname = fname:gsub("^.*lua/", "")
    fname = fname:gsub(".lua$", "")
    fname = fname:gsub(".init$", "")
    local module = fname:gsub("/", ".")
    return module
  end
  return ""
end

---@param plugin_name string
---@return boolean
function M.has_plugin(plugin_name) return require("lazy.core.config").plugins[plugin_name] ~= nil end

function M.get_installed_plugins()
  local plugins = require("lazy").plugins()
  local plugin_names = {}

  for _, plugin in ipairs(plugins) do
    table.insert(plugin_names, plugin.name)
  end

  return plugin_names
end

return M
