local M = {
  "akinsho/toggleterm.nvim",
}

function M.config()
  local toggleterm = require("toggleterm")
  toggleterm.setup({
    size = 20,
    open_mapping = [[<m-0>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  })

  function _G.set_terminal_keymaps()
    local opts = { noremap = true, silent = true, buffer = 0 }
    local map = vim.keymap.set
    -- map('t', '<esc>', [[<C-\><C-n>]], opts)
    -- map("t", "jk", [[<C-\><C-n>]], opts)
    map("t", "<m-h>", [[<C-\><C-n><C-W>h]], opts)
    map("t", "<m-j>", [[<C-\><C-n><C-W>j]], opts)
    map("t", "<m-k>", [[<C-\><C-n><C-W>k]], opts)
    map("t", "<m-l>", [[<C-\><C-n><C-W>l]], opts)
  end

  vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    on_open = function(_)
      vim.cmd("startinsert!")
      -- vim.cmd "set laststatus=0"
    end,
    on_close = function(_)
      -- vim.cmd "set laststatus=3"
    end,
    count = 99,
  })

  function _LAZYGIT_TOGGLE()
    lazygit:toggle()
  end

  local python =
      Terminal:new({ cmd = require("config.helper").get_python_path(vim.api.nvim_buf_get_name(0)), hidden = true })

  function _PYTHON_TOGGLE()
    python:toggle()
  end

  local float_term = Terminal:new({
    direction = "float",
    on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(
        term.bufnr,
        "n",
        "<m-1>",
        "<cmd>1ToggleTerm direction=float<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_buf_set_keymap(
        term.bufnr,
        "t",
        "<m-1>",
        "<cmd>1ToggleTerm direction=float<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_buf_set_keymap(
        term.bufnr,
        "i",
        "<m-1>",
        "<cmd>1ToggleTerm direction=float<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_buf_set_keymap(term.bufnr, "", "<m-2>", "<nop>", { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(term.bufnr, "", "<m-3>", "<nop>", { noremap = true, silent = true })
    end,
    count = 1,
  })

  function _FLOAT_TERM()
    float_term:toggle()
  end

  local vertical_term = Terminal:new({
    direction = "vertical",
    on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(
        term.bufnr,
        "n",
        "<m-2>",
        "<cmd>2ToggleTerm size=60 direction=vertical<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_buf_set_keymap(
        term.bufnr,
        "t",
        "<m-2>",
        "<cmd>2ToggleTerm size=60 direction=vertical<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_buf_set_keymap(
        term.bufnr,
        "i",
        "<m-2>",
        "<cmd>2ToggleTerm size=60 direction=vertical<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_buf_set_keymap(term.bufnr, "", "<m-3>", "<nop>", { noremap = true, silent = true })
    end,
    count = 2,
  })

  function _VERTICAL_TERM()
    vertical_term:toggle(60)
  end

  local horizontal_term = Terminal:new({
    direction = "horizontal",
    on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(
        term.bufnr,
        "n",
        "<m-3>",
        "<cmd>3ToggleTerm size=10 direction=horizontal<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_buf_set_keymap(
        term.bufnr,
        "t",
        "<m-3>",
        "<cmd>3ToggleTerm size=10 direction=horizontal<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_buf_set_keymap(
        term.bufnr,
        "i",
        "<m-3>",
        "<cmd>3ToggleTerm size=10 direction=horizontal<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_buf_set_keymap(term.bufnr, "", "<m-2>", "<nop>", { noremap = true, silent = true })
    end,
    count = 3,
  })

  function _HORIZONTAL_TERM()
    horizontal_term:toggle(10)
  end

  vim.api.nvim_create_user_command("Lazygit", function()
    _LAZYGIT_TOGGLE()
  end, { nargs = "*", desc = "Opening lazygit" })

end

M.keys = {
  { mode = "n", "<m-1>", "<cmd>lua _FLOAT_TERM()<CR>" },
  { mode = "i", "<m-1>", "<cmd>lua _FLOAT_TERM()<CR>" },
  { mode = "n", "<m-2>", "<cmd>lua _VERTICAL_TERM()<CR>" },
  { mode = "i", "<m-2>", "<cmd>lua _VERTICAL_TERM()<CR>" },
  { mode = "n", "<m-3>", "<cmd>lua _HORIZONTAL_TERM()<CR>" },
  { mode = "i", "<m-3>", "<cmd>lua _HORIZONTAL_TERM()<CR>" },
}

M.cmd = { "Lazygit" }

return M
