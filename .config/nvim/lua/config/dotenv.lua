-- NOTE: Stolen and modified from https://github.com/ellisonleao/dotenv.nvim

local DOTENV_GROUP = vim.api.nvim_create_augroup("Dotenv", { clear = true })

local dotenv = {}

dotenv.config = {
  event = "VimEnter",
  verbose = true,
  file_name = ".env",
}

local function notify(msg, level)
  if not dotenv.config.verbose then return end

  if level == nil then level = "INFO" end

  vim.notify(msg, vim.log.levels[level])
end

local function parse_data(data)
  local values = vim.split(data, "\n")
  local out = {}
  for _, pair in pairs(values) do
    pair = vim.trim(pair)
    if not vim.startswith(pair, "#") and pair ~= "" then
      local splitted = vim.split(pair, "=")
      if #splitted > 1 then
        local key = splitted[1]
        local v = {}
        for i = 2, #splitted, 1 do
          local k = vim.trim(splitted[i])
          if k ~= "" then table.insert(v, splitted[i]) end
        end
        if #v > 0 then
          local value = table.concat(v, "=")
          value, _ = string.gsub(value, '"', "")
          vim.env[key] = value
          out[key] = value
        end
      end
    end
  end
  return out
end

local function get_env_file()
  local files = vim.fs.find(dotenv.config.file_name, { upward = true, type = "file" })
  if #files == 0 then return end
  return files[1]
end

local function load(file)
  if file == nil then file = get_env_file() end

  local ok, data = pcall(require("config.helper").read_file, file)
  if not ok then
    notify(".env file not found", "ERROR")
    return
  end

  parse_data(data)
  notify(".env file loaded")
end

dotenv.autocmd = function() load() end

dotenv.command = function(opts)
  local args

  if opts ~= nil then
    if #opts.fargs > 0 then args = opts.fargs[1] end
  end

  load(args)
end

vim.api.nvim_create_user_command("Dotenv", function(opts) dotenv.command(opts) end, { nargs = "?", complete = "file" })
vim.api.nvim_create_user_command("DotenvGet", function(opts) dotenv.get(opts.fargs) end, { nargs = 1 })
vim.api.nvim_create_autocmd(dotenv.config.event, { group = DOTENV_GROUP, pattern = "*", callback = dotenv.autocmd })

-- Reload environment variables when .env file is saved
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = dotenv.config.file_name,
  callback = function() dotenv.command() end,
})
