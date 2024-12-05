local winid = vim.api.nvim_get_current_win()

-- activate spelling
vim.opt_local.spell = true

-- Enable line wrapping
vim.wo[winid].wrap = true

-- Set the width of the text to 80 characters
vim.wo[winid].colorcolumn = "80"
vim.bo.textwidth = 80
