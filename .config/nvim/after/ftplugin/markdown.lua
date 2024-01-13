local function conceal_strikethrough()
  -- markdown strikethrough for ~~strike~~
  vim.cmd([[
hi MyStrikethrough gui=strikethrough
" hi Conceal         guifg=red
call matchadd('MyStrikethrough', '\~\~\zs.\+\ze\~\~')
call matchadd('Conceal',  '\~\~\ze.\+\~\~', 10, -1, {'conceal':''})
call matchadd('Conceal',  '\~\~.\+\zs\~\~\ze', 10, -1, {'conceal':''})
]])
end

function BOLD_TEXT_UNDER_CURSOR()
  print(vim.fn.expand("<cword>"))
end

local bufnr = vim.fn.bufnr()
local opts = { noremap = true, silent = true, buffer = bufnr }
local map = vim.keymap.set

vim.cmd("set spell")
map("n", "<leader>cn", "<cmd>PeekOpen<CR>", opts)
conceal_strikethrough()
-- Function to replace visual marked text

-- Define the Lua function to change the visual marked text
-- Define the Lua function to change the visual marked text
--

local function get_selected_text_positions()
  local start_pos = vim.api.nvim_eval([[getpos("'<")]])
  local end_pos = vim.api.nvim_eval([[getpos("'>")]])

  -- Extract row and column from the position table
  local start_row, start_col = start_pos[2], start_pos[3]
  local end_row, end_col = end_pos[2], end_pos[3]

  -- must be decreased, cause it always of by one
  start_row = start_row - 1
  start_col = start_col - 1
  end_row = end_row - 1

  return start_row, start_col, end_row, end_col
end

local function get_selected_text(bufnr, start_row, start_col, end_row, end_col)
  local selected_text = vim.api.nvim_buf_get_text(bufnr, start_row, start_col, end_row, end_col, {})[1]
  return selected_text
end

local function change_selected_text(begin, ending)
  local start_row, start_col, end_row, end_col = get_selected_text_positions()
  local selected_text = get_selected_text(0, start_row, start_col, end_row, end_col)

  -- Replace the visual selection with the new text (replace with whatever text you want)
  local new_text = begin .. selected_text .. ending
  vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, { new_text })
end


function BOLD()
  change_selected_text("**", "**")
end

function ITALIC()
  change_selected_text("*", "*")
end

function STRIKE()
  change_selected_text("~~", "~~")
end
-- Map the function to a keybinding (you can change '<leader>t' to any key combination you prefer)
vim.api.nvim_set_keymap("v", "<leader>b", ":lua BOLD()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>i", ":lua ITALIC()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>s", ":lua STRIKE()<CR>", { noremap = true, silent = true })

-- FIX: DOES NOT WORK!!!
-- local function update_links()
--   -- TODO: using to update markdown link
--   local Job = require("plenary.job")
--
--   Job:new({
--     command = "rg",
--     args = { [[\[.*\]\(.*md.*\)]], vim.fn.expand("~") .. "/Documents/Notes/" },
--     env = { ["a"] = "b" },
--     on_exit = function(j, return_val)
--       -- print(vim.inspect())
--
--       for k, v init pairs(j:result()) do
--         print(v)
--       end
--     end,
--   }):sync() -- or start()
-- end
