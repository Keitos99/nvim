local M = {}

function M.is_existing_dir(path)
  return vim.fn.isdirectory(path) == 1
end

---@return number: number of listed/open buffers
function M.get_number_of_buffers()
  local possible_buffers = vim.fn.range(1, vim.fn.bufnr("$"))
  local unlisted_buffers = vim.fn.filter(possible_buffers, "buflisted(v:val)")
  local number_of_listed_buffers = vim.fn.len(unlisted_buffers)
  return number_of_listed_buffers
end

-- NOTE:use vim.fs.dirname(path)
function M.get_parent_dir(path)
  path = path:match("^(.*)/")
  if path == "" then
    return ""
  end

  return path
end

function M.exists(path)
  local stat = vim.loop.fs_stat(path)
  return stat ~= nil
end

function M.sync_job(cmd, args)
  local Job = require("plenary.job")
  local job = Job:new({
    command = cmd,
    args = args,
  })
  job:sync()
  return job:result()
end

function M.has_value(table, element)
  if type(table) ~= "table" then
    return false
  end

  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function M.is_empty(table)
  return next(table) == nil
end

function M.cmd_to_table(cmd)
  local temp_table = {}
  local pipe = io.popen(cmd)
  if pipe == nil then
    return temp_table
  end

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
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
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

      if root ~= nil or path == "/" then
        should_run = false
      end
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
    print("Deleted Module " .. module)
    return module
  end
  return ""
end

function M.get_line_byte_length(line_number)
  local line = vim.api.nvim_buf_get_lines(0, line_number - 1, line_number, false)[1]
  return #line
end

function M.region_to_text(region)
  local text = ""
  local maxcol = vim.v.maxcol + 1
  for line, cols in vim.spairs(region) do
    line = line - 1
    local endcol = cols[2] == maxcol and -1 or cols[2]
    local chunk = vim.api.nvim_buf_get_text(0, line, cols[1], line, endcol, {})[1]
    text = ("%s%s\n"):format(text, chunk)
  end
  return text
end

function M.get_visual_selection()
  local beginning = vim.api.nvim_buf_get_mark(0, "<")
  local ending = vim.api.nvim_buf_get_mark(0, ">")
  local region = vim.region(0, beginning, ending, "v", true)
  return M.region_to_text(region)
end

function M.has(plugin)
  return require("plug")[plugin] ~= nil
end

return M
