return {
  {
    "zbirenbaum/copilot.lua",
    lazy = false,
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<C-a>",
          accept_word = false,
          accept_line = false,
          next = "<M-j>",
          prev = "<M-k>",
          dismiss = "<C-]>",
        },
      },
      -- Node.js version must be > 18.x
      copilot_node_command = vim.fn.expand("$HOME") .. "/.config/nvm/versions/node/v18.0.0/bin/node",
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    lazy = false,
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
