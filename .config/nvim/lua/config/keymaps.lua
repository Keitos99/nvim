--    +-------------------------------------------------------------------------------------------------+
--    | Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator | Terminal | Lang-Arg |
--    ---------------------------------------------------------------------------------------------------
--    | map  / noremap   |    @   |   -    |    -    |   @    |   @    |    @     |    -     |    -     |
--    | nmap / nnoremap  |    @   |   -    |    -    |   -    |   -    |    -     |    -     |    -     |
--    | map! / noremap!  |    -   |   @    |    @    |   -    |   -    |    -     |    -     |    -     |
--    | imap / inoremap  |    -   |   @    |    -    |   -    |   -    |    -     |    -     |    -     |
--    | cmap / cnoremap  |    -   |   -    |    @    |   -    |   -    |    -     |    -     |    -     |
--    | vmap / vnoremap  |    -   |   -    |    -    |   @    |   @    |    -     |    -     |    -     |
--    | xmap / xnoremap  |    -   |   -    |    -    |   @    |   -    |    -     |    -     |    -     |
--    | smap / snoremap  |    -   |   -    |    -    |   -    |   @    |    -     |    -     |    -     |
--    | omap / onoremap  |    -   |   -    |    -    |   -    |   -    |    @     |    -     |    -     |
--    | tmap / tnoremap  |    -   |   -    |    -    |   -    |   -    |    -     |    @     |    -     |
--    | lmap / lnoremap  |    -   |   @    |    @    |   -    |   -    |    -     |    -     |    @     |
--    +-------------------------------------------------------------------------------------------------+
-- Special beginners
-- <S = Shift
-- <C = Control
-- <A or <M = Alt

local map = function(mode, key, result, options)
  local default_opts = { noremap = true, silent = true }
  local opts = vim.tbl_extend("force", default_opts, options or {})
  vim.keymap.set(mode, key, result, opts)
end

map("", "<Space>", "<Nop>")

-- moving between windows NOTE: will be overwritten by vim-tmux-navigator
map("n", "<C-h>", "<C-w>h", { desc = "Move to the window to the left" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to the window below" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to the window above" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to the window to the right" })

-- resize windows wit description
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Resize the window up" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Resize the window down" })
map("n", "<C-Left>", ":vertical resize +2<CR>", { desc = "Resize the window to the left" })
map("n", "<C-Right>", ":vertical resize -2<CR>", { desc = "Resize the window to the right" })

-- buffers
map("n", "<S-q>", ":bdelete<CR>", { desc = "Close the current buffer" })

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- paste/copy to the system clipboard
map({ "n", "v" }, "gy", '"+y', { desc = "Copy to the system clipboard" })
map({ "n", "v" }, "gp", '"+p', { desc = "Paste from the system clipboard" })

-- paste without changing the registers, when you are in the insert mode
map("x", "p", '"_dP', { desc = "Paste without changing the registers" })

-- select all
map("n", "<leader>aa", ":keepjumps normal! ggVG<cr>", { desc = "Select all" })

-- Visual Block --
-- Move text up and down
map("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move the selected text down" })
map("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move the selected text up" })

-- center the screen after pressing n
map({ "n", "x", "o" }, "n", "nzzzv")
map({ "n", "x", "o" }, "N", "Nzzzv")

map("n", "<leader>ss", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", {
  silent = false, -- to see the command
  desc = "Replace all occurrences of the word under the cursor",
})
