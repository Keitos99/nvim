local M = {
  -- for automatically highlighting other uses of the word under the cursor,
  -- using either LSP, Tree-sitter, or regex matching.
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" }
}

function M.config()
  local illuminate = require("illuminate")
  -- <A-n> and <A-p> for moving between references
  -- <A-i> for as a textopbject under the cursor TODO: no plan what that means

  illuminate.configure({
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
      "lsp",
      "treesitter",
      "regex",
    },
    delay = 100, -- delay in milliseconds
    filetype_overrides = {},
    filetypes_denylist = {
      "dirvish",
      "fugitive",
      "NvimTree",
    },
    under_cursor = true,
    large_file_cutoff = nil,
    large_file_overrides = nil,
  })
end

return M
