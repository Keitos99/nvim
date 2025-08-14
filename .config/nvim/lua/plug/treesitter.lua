function is_to_large(lang, buf)
  local max_filesize = 300 * 1024 -- 300 KB
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  if ok and stats and stats.size > max_filesize then
    vim.notify_once("Disabled for " .. tostring(lang) .. ": " .. stats.size)
    return false
  end
end

return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufReadPost",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  init = function()
    local use_ts_folding = function()
      -- enable folding
      vim.opt.foldmethod = "expr"
      vim.o.foldexpr = "nvim_treesitter#foldexpr()"
    end

    vim.keymap.set("n", "<leader>tf", use_ts_folding)
  end,
  opts = {
    ensure_installed = require("config.globals").tree_sitter_parsers,
    sync_install = false,
    ignore_install = { "swift", "help" }, -- List of parsers to ignore installing
    auto_install = false,
    highlight = {
      enable = true, -- enable treesitter highlighting
      disable = is_to_large, -- list of language that will be disabled
      additional_vim_regex_highlighting = false,
    },
    textobjects = {
      lookahead = true,
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]f"] = "@function.outer",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
        },
      },
    },
  },
  config = function(_, opts)
    -- lazy.nvim will normally try to call nvim.treesitter.setup
    require("nvim-treesitter.configs").setup(opts)
  end,
}
