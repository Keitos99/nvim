return {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    function ColorMyPencils(color)
      color = color or "rose-pine"
      vim.cmd.colorscheme(color)

      -- make background transparent
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end

    ColorMyPencils("rose-pine")
  end,
}
