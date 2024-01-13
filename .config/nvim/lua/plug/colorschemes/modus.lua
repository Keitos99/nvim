return {
  "miikanissi/modus-themes.nvim",
  config = function()
    require("modus-themes").setup({
      -- Theme comes in two styles `modus_operandi` and `modus_vivendi`
      -- `auto` will automatically set style based on background set with vim.o.background
      style = "auto",
      variant = "default",  -- Theme comes in four variants `default`, `tinted`, `deuteranopia`, and `tritanopia`
      dim_inactive = false, -- "non-current" windows are dimmed
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { bold = true },
        functions = {},
        variables = {},
      },
    })

    vim.cmd.colorscheme({ "modus" })
  end
}
