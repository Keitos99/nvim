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


local Plugins = require('plug')
local function has(name)
  return Plugins[name] ~= nil
end

local opts = { noremap = true, silent = true }
local map = vim.keymap.set

map("", "<Space>", "<Nop>", opts)
map("i", "jk", "<esc>", opts)

-- moving between windows
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- buffers
if has("bufferline.nvim") then
  map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
  map("n", "<S-q>", ":bdelete<CR>", opts)
else
  map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
  map("n", "<S-q>", ":bdelete<CR>", opts)
end

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- paste/copy to the system clipboard
map({ "n", "v" }, "gy", '"+y', opts)
map({ "n", "v" }, "gp", '"+p', opts)

-- paste without changing the registers, when you are in the insert mode
map("x", "p", '"_dP', opts)

-- select all
map('n', '<leader>a', ':keepjumps normal! ggVG<cr>')


-- Visual Block --
-- Move text up and down
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)

map("n", "C-J", "<cmd>clext<cr>zz", opts)
map("n", "C-K", "<cmd>clrev<cr>zz", opts)

-- center the screen after pressing n
map({ "n", "x", "o" }, "n", "nzzzv", opts)
map({ "n", "x", "o" }, "N", "Nzzzv", opts)

-- replace all occurrences of the word under the cursor
map("n", "<leader>ss", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- disable hlsearch automatically when your search is done. Enable it, when pressing one of the defined keys
local ns = vim.api.nvim_create_namespace("toggle_hlsearch")

local function toggle_hlsearch(char)
  if vim.fn.mode() ~= "n" then
    return
  end

  local keys = { "<CR>", "n", "N", "*", "#", "?", "/" }
  local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))

  if vim.opt.hlsearch:get() ~= new_hlsearch then
    vim.opt.hlsearch = new_hlsearch
  end
end

vim.on_key(toggle_hlsearch, ns)
