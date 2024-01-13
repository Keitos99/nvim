local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd

local hint = [[
                 _f_: files       _G_: grep string under the Cursor
   🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼    _o_: old files   _g_: live grep
  🭉🭁🭠🭘    🭣🭕🭌🬾   _p_: projects    _s_: sessions
  🭅█ ▁     █🭐
  ██🬿      🭊██   _r_: resume      _u_: undotree
 🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀  _h_: vim help    _c_: execute command
 🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙  _k_: keymaps     _;_: commands history
                 _O_: options     _?_: search history
                 _b_: buffers     _m_: marks

 ^
                 _<Enter>_: Telescope           _<Esc>_
]]

Hydra({
  name = "Telescope",
  hint = hint,
  config = {
    color = "teal",
    invoke_on_body = true,
    hint = {
      position = "middle",
      border = "rounded",
    },
  },
  mode = { "n", "v" },
  body = "<leader>f",
  heads = {
    { "f", cmd("Telescope find_files") },
    {
      "g",
      function()
        vim.ui.input({ prompt = "Grep > " }, function(input)
          local builtin = require("telescope.builtin")
          builtin.grep_string({
            search = input,
          })
        end)
      end,
    },
    { "G", cmd("Telescope grep_string") },
    { "o", cmd("Telescope oldfiles"), { desc = "recently opened files" } },
    { "h", cmd("Telescope help_tags"), { desc = "vim help" } },
    { "m", cmd("Telescope marks"), { desc = "media files" } },
    { "b", cmd("Telescope buffers"), { desc = "marks" } },
    { "k", cmd("Telescope keymaps") },
    { "O", cmd("Telescope vim_options") },
    { "r", cmd("Telescope resume") },
    { "s", cmd("Telescope persisted"), { desc = "persited sessions" } },
    { "p", cmd("Telescope projects"), { desc = "projects" } },
    { "?", cmd("Telescope search_history"), { desc = "search history" } },
    { ";", cmd("Telescope command_history"), { desc = "command-line history" } },
    { "c", cmd("Telescope commands"), { desc = "execute command" } },
    { "u", cmd("silent! %foldopen! | UndotreeToggle"), { desc = "undotree" } },
    { "<Enter>", cmd("Telescope"), { exit = true, desc = "list all pickers" } },
    { "<Esc>", nil, { exit = true, nowait = true } },
  },
})
