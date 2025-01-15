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

-- easily exit terminal mode
map("t", "<esc><esc>", "<c-\\><c-n>")

-- moving between windows NOTE: will be overwritten by vim-tmux-navigator
map("n", "<C-h>", "<C-w>h", { desc = "Move to the window to the left" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to the window below" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to the window above" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to the window to the right" })

local resize_window = require("config.helper.window").resize_window
map("n", "<M-j>", function() resize_window("j", 2) end, { desc = "Increase the window height" })
map("n", "<M-k>", function() resize_window("j", -2) end, { desc = "Decrease the window height" })
map("n", "<M-l>", function() resize_window("h", 2) end, { desc = "Increase the window width" })
map("n", "<M-h>", function() resize_window("h", -2) end, { desc = "Decrease the window width" })

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
map("n", "gaa", ":keepjumps normal! ggVG<cr>", { desc = "Select all" })

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

local function move_registery(r1, r2) vim.fn.setreg(r1, vim.fn.getreg(r2)) end
map(
  "n",
  "yc",
  function() move_registery("+", '"') end,
  { noremap = true, desc = "move contents of anon register to system cliboard register" }
)
