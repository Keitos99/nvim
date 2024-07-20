local dapui = require("dapui")

dapui.setup({
  element_mappings = {},
  force_buffers = true,
  controls = {
    enabled = vim.fn.exists("+winbar") == 1,
    element = "console",
    -- repl Buttons
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "",
      terminate = "",
      disconnect = "",
    },
  },
  icons = { expanded = "▾", collapsed = "▸", current_frame = "" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = false, -- NOTE: when true and the line is to long, then it becomes unreadable
  layouts = {
    -- Layout 1
    {
      elements = {
        {
          id = "console",
          size = 0.75,
        },
        {
          id = "repl",
          size = 0.25,
        },
      },
      position = "bottom",
      size = 10,
    },
    -- Layout 2
    {
      elements = {
        "scopes",
        "breakpoints",
        -- "watches",
      },
      size = 0.25,
      position = "right",
    },

    -- Layout 3
    {
      elements = {
        "stacks",
      },
      size = 10,
      position = "bottom",
    },

    -- Layout 4
    {
      elements = {
        "scopes",
        "watches",
      },
      size = 0.25,
      position = "right",
    },
  },
  floating = {
    max_width = 0.9,
    max_height = 0.9,
    border = "rounded",
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    indent = 1,
  },
})

return dapui
