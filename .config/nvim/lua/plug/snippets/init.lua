local M = {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
}

function M.config()
  local status_ok, ls = pcall(require, "luasnip")
  if not status_ok then
    vim.notify("Could not load luasnip")
    return
  end

  -- some shorthands...
  local snippet = ls.snippet
  -- local node = ls.snippet_node
  local text = ls.text_node
  local insert = ls.insert_node
  local func = ls.function_node
  -- local choice = ls.choice_node
  -- local dynamicn = ls.dynamic_node

  -- some keymaps
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }
  keymap("i", "<c-j>", function()
    require("luasnip").jump(1)
  end, opts)
  keymap("s", "<c-j>", function()
    require("luasnip").jump(1)
  end, opts)
  keymap("i", "<c-k>", function()
    require("luasnip").jump(-1)
  end, opts)
  keymap("s", "<c-k>", function()
    require("luasnip").jump(-1)
  end, opts)

  ls.config.set_config({
    history = true,
    -- treesitter-hl has 100, use something higher (default is 200).
    ext_base_prio = 200,
    -- minimal increase in priority.
    ext_prio_increase = 1,
    enable_autosnippets = false,
    store_selection_keys = "<c-s>",
  })

  ls.add_snippets(nil, {
    all = require("plug.snippets.all"),
    python = require("plug.snippets.python"),
    lua = require("plug.snippets.lua"),
    markdown = require("plug.snippets.markdown"),
    go = require("plug.snippets.go"),
  })

  ls.filetype_extend("telekasten", { "markdown" })
  ls.filetype_extend("vimwiki", { "markdown" })
end

return M
