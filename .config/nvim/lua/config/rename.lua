local SUPPORTED_FILE_EXTENSIONS = { py = ".py", lua = ".lua" }
local MODULE_MARKERS = { [".py"] = "__init__", [".lua"] = "init" }
local helper = require("config.helper")

-- determines in which language the project was written, based of the files in the directory
local function determine_dir_file_type(directory)
  for type, extension in pairs(SUPPORTED_FILE_EXTENSIONS) do
    local globs = vim.fn.glob(directory .. "/" .. "*" .. extension)
    if globs ~= "" then
      return type
    end
  end

  return nil
end

local function escaped_replace(str, what, with)
  what = string.gsub(what, "[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1") -- escape pattern
  with = string.gsub(with, "[%%]", "%%%%") -- escape replacement
  return string.gsub(str, what, with)
end

local function get_file_extension(fname)
  local extension = fname:match("^.+(%..+)$")
  if extension == nil then
    return ""
  end
  return extension
end

local function ends_with(str, ending)
  return ending == "" or str:sub(-#ending) == ending
end

local function is_supported_file_type(path)
  return helper.has_value(SUPPORTED_FILE_EXTENSIONS, get_file_extension(path))
end

local function get_module_marker(fname)
  local module_marker = MODULE_MARKERS[get_file_extension(fname)]

  if module_marker == nil then
    -- there are not module maker for this file type
    return ""
  end
  return module_marker
end

local function generate_import_string(path)
  local working_dir = vim.fn.getcwd()
  local import_string = escaped_replace(path, working_dir, "")
  import_string = escaped_replace(import_string, "/", "."):sub(2)

  -- remove the file extension
  import_string = string.gsub(import_string, "%" .. get_file_extension(path) .. "$", "")

  -- special treatment, for nvim lua files
  import_string = import_string:gsub("lua.", "")

  -- remove module markers like __init__.py or init.lua from the import string
  import_string = import_string:gsub("." .. get_module_marker(path), "")
  return import_string
end

local function rename_file_imports(old_name, new_name)
  local old_import_string = generate_import_string(old_name)
  local new_import_string = generate_import_string(new_name)

  local working_dir = vim.fn.getcwd()
  local find_and_replace_args = working_dir
    .. " -name *"
    .. get_file_extension(old_name)
    .. " -type f -exec sed -i -e s/"
    .. "\\<"
    .. old_import_string
    .. "\\>"
    .. "/"
    .. new_import_string
    .. "/g -- {} +"

  local cmd = "find"
  local args = vim.split(find_and_replace_args, " ") -- TODO: this is STUPID, but i am too lazy

  local Job = require("plenary.job")
  Job:new({
    command = cmd,
    args = args,
    on_exit = vim.schedule_wrap(function(j, code)
      print(code)
    end),
  }):start()
end

-- TODO: could ignore __pycache__ and .venv,
local function rename_dir_imports(old_dir_path, new_dir_path)
  local projects_file_extension = SUPPORTED_FILE_EXTENSIONS[determine_dir_file_type(new_dir_path)]
  if projects_file_extension == nil then
    vim.notify("Could not rename the directory, because the project typ could not be determined")
    return
  end

  local find_cmd = "find"
  local find_files_arguments = {
    new_dir_path,
    "-type",
    "f", -- only search for files
    "-name",
    "*" .. projects_file_extension,
  }

  local Job = require("plenary.job")
  Job:new({
    command = find_cmd,
    args = find_files_arguments,
    on_exit = vim.schedule_wrap(function(j, code)
      if code == 2 then
      end

      if code == 1 then
      end

      local filepaths = j:result()
      for _, filepath in ipairs(filepaths) do
        local old_filepath = escaped_replace(filepath, new_dir_path, old_dir_path)
        rename_file_imports(old_filepath, filepath)
      end

    vim.api.nvim_command("LspRestart")
    vim.cmd("bufdo e") -- reloading all the files, so that the changes are visible
    end),
  }):sync()
end

local M = {}

function M.on_node_renamed(old_name, new_name)
  if not helper.is_existing_dir(old_name) and helper.is_existing_dir(new_name) then
    -- a directory was renamed
    rename_dir_imports(old_name, new_name)
    return
  end

  -- a file was renamed
  if not is_supported_file_type(old_name) or not is_supported_file_type(new_name) then
    -- This file does not belong to a supported file type
    return
  end

  rename_file_imports(old_name, new_name)
  vim.api.nvim_command("LspRestart") -- the lsp must be notified about the changes
  vim.cmd("bufdo e") -- reloading all the files, so that the changes are visible
end

return M
