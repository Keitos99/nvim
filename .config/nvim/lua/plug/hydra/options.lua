require("hydra.hint.vim-options").search_highlight = function()
	if vim.o.hlsearch then
		return "[x]"
	end
	return "[ ]"
end
require("hydra.hint.vim-options").highl = require("hydra.hint.vim-options").search_highlight

local OptionHydra = require("hydra")

local option_hint = [[
  ^ ^        Options
  ^
  _v_ %{ve} virtual edit
  _i_ %{list} invisible characters  
  _s_ %{spell} spell
  _w_ %{wrap} wrap
  _c_ %{cul} cursor line
  _n_ %{nu} number
  _r_ %{rnu} relative number
  _h_ %{highl} highlight searchs
  ^
       ^^^^                _<Esc>_
]]

OptionHydra({
	name = "Options",
	hint = option_hint,
	config = {
		color = "amaranth",
		invoke_on_body = true,
		hint = {
			border = "rounded",
			position = "middle",
		},
	},
	mode = { "n", "x" },
	body = "<leader>o",
	heads = {
		{
			"n",
			function()
				if vim.o.number == true then
					vim.o.number = false
				else
					vim.o.number = true
				end
			end,
			{ desc = "number" },
		},
		{
			"r",
			function()
				vim.o.relativenumber = not vim.o.relativenumber
			end,
			{ desc = "relativenumber" },
		},
		{
			"v",
			function()
				if vim.o.virtualedit == "all" then
					vim.o.virtualedit = "block"
				else
					vim.o.virtualedit = "all"
				end
			end,
			{ desc = "virtualedit" },
		},
		{
			"i",
			function()
				vim.o.list = not vim.o.list
			end,
			{ desc = "show invisible" },
		},
		{
			"s",
			function()
				vim.o.spell = not vim.o.spell
			end,
			{ desc = "spell" },
		},
		{
			"w",
			function()
				if vim.o.wrap ~= true then
					vim.o.wrap = true
					vim.keymap.set("n", "k", function()
						return vim.v.count > 0 and "k" or "gk"
					end, { expr = true, desc = "k or gk" })
					vim.keymap.set("n", "j", function()
						return vim.v.count > 0 and "j" or "gj"
					end, { expr = true, desc = "j or gj" })
				else
					vim.o.wrap = false
					vim.keymap.del("n", "k")
					vim.keymap.del("n", "j")
				end
			end,
			{ desc = "wrap" },
		},
		{
			"c",
			function()
				vim.o.cursorline = not vim.o.cursorline
			end,
			{ desc = "cursor line" },
		},
		{
			"h",
			function()
				vim.o.hlsearch = not vim.o.hlsearch
			end,
			{ desc = "toggle hlsearch" },
		},
		{ "<Esc>", nil, { exit = true } },
	},
})
