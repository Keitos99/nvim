vim.opt_local.conceallevel = 2 -- so that `` is visible in markdown files
vim.opt_local.spell = true

local map = vim.keymap.set
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr }
map("n", "<leader>dc", "<Cmd>ObsidianOpen<CR>", opts)
