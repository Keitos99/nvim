return {
  "rebelot/kanagawa.nvim",
  config = function()
    local kanagawa = require("kanagawa")

    kanagawa.setup({
      transparent = true,
      overrides = function(colors)
        local pallette = colors.palette
        local theme = colors.theme

        -- TODO: replace pallette with theme
        return {
          FloatTitle = { fg = pallette.sumiInk0, bg = pallette.oniViolet, bold = true },
          DressingInputNormalFloat = { bg = pallette.sumiInk0 },
          DressingInputFloatBorder = { fg = pallette.sumiInk0, bg = pallette.sumiInk0 },
          DiagnosticLineError = { bg = "#2f2424" },
          DiagnosticLineWarn = { bg = "#2f2b24" },

          -- Block-like modern Telescope UI
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

          -- Neotest
          NeotestAdapterName = { fg = pallette.autumnRed },
          NeotestDir = { link = "Directory" },
          NeotestExpandMarker = { fg = pallette.sumiInk2 },
          NeotestFailed = { fg = pallette.samuraiRed },
          NeotestFile = { link = "Directory" },
          NeotestFocused = { underline = false, bold = true },
          NeotestIndent = { fg = pallette.sumiInk2 },
          NeotestMarked = { fg = pallette.springBlue },
          NeotestNamespace = { bold = true, fg = pallette.dragonBlue },
          NeotestPassed = { fg = pallette.springGreen },
          NeotestRunning = { fg = pallette.autumnYellow },
          NeotestSkipped = { fg = pallette.springViolet1 },
          NeotestTarget = { fg = pallette.roninYellow },
          NeotestWinSelect = { fg = pallette.sumiInk0, bg = pallette.waveBlue2 },

          -- NotifierContentError = { fg = pallette.autumnRed },
          -- NotifierContentWarn = { fg = pallette.autumnYellow },
          -- NotifierTitle = { link = "Comment" },
          -- TabLine = { fg = pallette.katanaGray, bg = pallette.sumiInk3 },
          -- TabLineFill = { bg = pallette.sumiInk1 },
          -- TabLineSel = { fg = pallette.oniViolet, bg = pallette.sumiInk2, bold = true },
          -- TabLineSelSpacing = { bg = pallette.sumiInk1, fg = pallette.sumiInk2 },
          -- TabLineSpacing = { bg = pallette.sumiInk1, fg = pallette.sumiInk3 },
          --
        }
      end,
    })

    vim.cmd.colorscheme({ "kanagawa-wave" })
  end,
}
