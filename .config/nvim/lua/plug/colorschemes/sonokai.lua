return {
  "sainnhe/sonokai",
  config = function()
    vim.g.sonokai_style = "atlantis"
    vim.cmd.colorscheme({ "sonokai" })
  end,
}
