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

-- this function is based on the plugin mrjones2014/smart-splits.nvim
local function resize_window(direction, amount)
  ---@param direction string
  ---@return string
  local function get_opposite_direction(direction)
    if direction == "h" then return "l" end
    if direction == "l" then return "h" end
    if direction == "j" then return "k" end
    if direction == "k" then return "j" end

    assert(false, "Invalid direction " .. direction)
    return ""
  end

  ---@param amount integer
  ---@return string
  local function format_amount(amount)
    if amount > 0 then
      return "+" .. amount
    else
      -- the minus sign will automatically be added
      return tostring(amount)
    end
  end

  local winnr = vim.fn.winnr()
  local is_at_edge = vim.fn.winnr(direction) == winnr
  local is_opposite_edge = vim.fn.winnr(get_opposite_direction(direction)) == winnr

  local is_horizontal_resize = direction == "h" or direction == "l"
  local resize_cmd = is_horizontal_resize and "vertical resize" or "resize"
  if is_at_edge then
    -- resize the window in the given direction
    vim.cmd(resize_cmd .. " " .. format_amount(amount))
  elseif is_opposite_edge then
    -- resize the window in the opposite direction
    vim.cmd(resize_cmd .. " " .. format_amount(-1 * amount))
  else
    -- is somewhere in the middle, so resize the window in the given direction
    vim.cmd(resize_cmd .. " " .. format_amount(amount))
  end
end

map("", "<Space>", "<Nop>")

-- moving between windows NOTE: will be overwritten by vim-tmux-navigator
map("n", "<C-h>", "<C-w>h", { desc = "Move to the window to the left" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to the window below" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to the window above" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to the window to the right" })

map("n", "<C-Up>", function() resize_window("j", 2) end, { desc = "Increase the window height" })
map("n", "<C-Down>", function() resize_window("j", -2) end, { desc = "Decrease the window height" })
map("n", "<C-Right>", function() resize_window("h", 2) end, { desc = "Increase the window width" })
map("n", "<C-Left>", function() resize_window("h", -2) end, { desc = "Decrease the window width" })

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
