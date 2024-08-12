local M = {}

M.mason = {
  tools = { "sql-formatter", "stylua" },
  lsps = {
    "lua_ls",
    "pyright",
    "vimls",
    "bashls",
    "yamlls",
    "tsserver",
    "marksman",
    -- "sqls",
  },
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
  ".4gl",
  ".obsidian",
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
  "vimdoc",
}

M.jdtls = {
  vmArgs = vim.env.NVIM_JDTLS_VM_ARGS and vim.env.NVIM_JDTLS_VM_ARGS or "",
  args = vim.env.NVIM_JDTLS_ARGS and vim.env.NVIM_JDTLS_ARGS or "",
}

return M
