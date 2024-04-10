return {
  -- A high-performance color highlighter for Neovim
  "NvChad/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    user_default_options = {
      filetypes = { "*", "!lazy" },
      buftype = { "*", "!prompt", "!nofile" },
      --     -- Available modes for `mode`: foreground, background,  virtualtext
      mode = "background", -- Set the display mode.
      virtualtext = "■",
      names = false,
    },
  },
}
