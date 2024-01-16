local M = {
  url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  name = "lsp_lines",
  event = "LspAttach",
  -- enabled = false, -- BUG: Lazy.nvim can not reach the website
}

M.config = function()
  local lsp_lines = require("lsp_lines")
  lsp_lines.setup()
end

M.keys = {
  {
    "<A-d>", -- on hesitation
    function()
      require("lsp_lines").toggle()
    end,
  },
}
return M
