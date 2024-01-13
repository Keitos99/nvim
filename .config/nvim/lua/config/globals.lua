local M = {}

M.mason = {
  tools = { "autopep8", "clang-format", "sql-formatter", "stylua", "beautysh" },
  lsps = { "lua_ls", "pyright", "vimls", "clangd", "bashls", "yamlls", "tsserver", "marksman", --[[ "sqls" ]] },
  install_dir = vim.fn.stdpath("data") .. "/mason",
}

M.root_patterns = {
  ".git",
  "_darcs",
  ".hg",
  ".bzr",
  ".svn",
  "Makefile",
  "makefile",
  "package.json",
  "src",
  ".stylua.toml",
  -- ".cvsignore",
}

M.tree_sitter_parsers = {
  "sql",
  "java",
  "lua",
  "python",
  "vim",
  "cpp",
  "c",
  "bash",
  "javascript",
  "yaml",
  "markdown",
  "markdown_inline",
  "latex",
}

M.jdtls = {
  vmArgs = vim.env.NVIM_JDTLS_VM_ARGS and vim.env.NVIM_JDTLS_VM_ARGS or "",
  args = vim.env.NVIM_JDTLS_ARGS and vim.env.NVIM_JDTLS_ARGS or "",
}

return M
