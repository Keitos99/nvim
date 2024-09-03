return {
  {
    "github/copilot.vim",
    lazy = false,
    init = function()
      vim.keymap.set("i", "<C-a>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
      vim.g.copilot_no_tab_map = true
    end,
  },
  {
    "robitx/gp.nvim",
    lazy = false,
    config = function()
      local conf = {
        -- For customization, refer to Install > Configuration in the Documentation/Readme
        providers = {
          copilot = {
            endpoint = "https://api.githubcopilot.com/chat/completions",
            secret = {
              "bash",
              "-c",
              "cat ~/.config/github-copilot/apps.json | sed -e 's/.*oauth_token...//;s/\".*//'",
            },
          },
        },
      }
      require("gp").setup(conf)

      -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
    end,
  },
}
