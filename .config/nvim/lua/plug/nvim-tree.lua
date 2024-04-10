local M = {
  "kyazdani42/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "NvimTreeToggle" },
  },
}

local icons = require("config.ui.icons")
local doc_icons = icons.documents
local git_icons = icons.nvim_tree.git

local function open_qflist_on_delete(datas)
  local helper = require("config.helper")
  local filename = ""

  if datas["fname"] ~= nil then
    filename = datas.fname
  end

  if datas["old_name"] ~= nil then
    filename = datas.old_name
  end

  if datas["folder_name"] ~= nil then
    filename = datas.folder_name
  end

  if filename == "" then
    return
  end

  local command = "rg"
  local module_name = helper.get_module(filename)
  local fname_parent = vim.fs.dirname(filename)
  local root_dir = helper.find_root(fname_parent)

  if module_name == "" then
    return
  end

  local search_regex = '"' .. module_name .. '.*"'
  print(search_regex)
  print(filename)

  local args = {
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    search_regex,
    root_dir,
  }

  local Job = require("plenary.job")
  Job:new({
    command = command,
    args = args,
    on_exit = vim.schedule_wrap(function(j, code)
      if code == 2 then
        local error = table.concat(j:stderr_result(), "\n")
        print(command .. " failed with code " .. code .. "\n" .. error)
      end

      if code == 1 then
        print("No usage of the module " .. module_name)
      end

      local results = {}
      local lines = j:result()
      for _, line in ipairs(lines) do
        local file, row, col, text = line:match("^(.+):(%d+):(%d+):(.*)$")
        local item = { filename = file, lnum = tonumber(row), col = tonumber(col), line = text }
        item.tag = "Sayan"
        item.text = vim.trim(text)
        item.message = vim.trim(text)
        table.insert(results, item)
      end

      vim.notify("The File " .. filename .. " is been used. Opening a qflist")
      if #lines > 0 then
        vim.fn.setqflist({}, " ", { title = "Todo", items = results })
        vim.cmd("cwindow")
      end
    end),
  }):sync()
end

function autocmds()
  local rename = require("config.rename")
  local api = require("nvim-tree.api")
  local Event = api.events.Event

  api.events.subscribe(Event.FileRemoved, open_qflist_on_delete)
  api.events.subscribe(Event.FolderRemoved, open_qflist_on_delete)

  -- NOTE: for renaming over the lsp look here https://github.com/nvim-tree/nvim-tree.lua/pull/1821
  -- https://github.com/antosha417/nvim-lsp-file-operations plugin seems promising
  -- it uses the WillRename-Lsp-Request
  -- util then use the following
  api.events.subscribe(Event.NodeRenamed, function(data)
    rename.on_node_renamed(data.old_name, data.new_name)
  end)
end

M.config = function()
  require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = true,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = true,

    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true,
      update_cwd = true,
      ignore_list = {},
    },
    git = {
      enable = true,
      ignore = true,
      timeout = 500,
    },

    diagnostics = {
      enable = true,
      icons = {
        hint = icons.diagnostics.Hint,
        info = icons.diagnostics.Information,
        warning = icons.diagnostics.Warning,
        error = icons.diagnostics.Error,
      },
    },
    renderer = {
      icons = {
        webdev_colors = true,
        git_placement = "before",
        padding = " ",
        symlink_arrow = " ➛ ",
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
        glyphs = {
          default = doc_icons.File.Default,
          symlink = doc_icons.File.Symlink,
          folder = {
            default = doc_icons.Folder.Default,
            open = doc_icons.Folder.Open,
            empty = doc_icons.Folder.Empty,
            empty_open = doc_icons.Folder.EmptyOpen,
            symlink = doc_icons.Folder.Symlink,
          },
          git = git_icons,
        },
      },
      special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "ReadMe.md" },
    },
  })
  autocmds()
end

return M
