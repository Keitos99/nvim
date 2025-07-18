local M = {}

M.mason = {
  tools = {
    "sql-formatter",
    "stylua",
    "eslint_d",
    "ruff",
    "selene",
    "black",
    "isort",
    "beautysh",
    "prettier",
    "prettierd",
  },
  lsps = {
    "lua_ls",
    "vimls",
    "bashls",
    "yamlls",
    "basedpyright",
    "marksman",
    "ts_ls",
    "svelte",
    "eslint", -- eslint-lsp
    "tailwindcss",
    "cssls",
    "harper_ls",
    "rust_analyzer",
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
  "tsconfig.json", -- Added for TypeScript projects
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
  "rust",
}

return M
