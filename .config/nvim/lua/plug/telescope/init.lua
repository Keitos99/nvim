---@type LazySpec
local M = {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x", -- release branch, which can have breaking changes
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = { "Telescope" },
  keys = {

    { "<leader>ff", "<cmd>Telescope find_files<cr>" },
    {
      "<leader>fg",
      function()
        vim.ui.input({ prompt = "Grep > " }, function(input)
          local builtin = require("telescope.builtin")
          builtin.grep_string({
            search = input,
          })
        end)
      end,
    },
    { "<leader>fG", "<cmd>Telescope grep_string<cr>" },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "recently opened files" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "vim help" },
    { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "media files" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "marks" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>" },
    { "<leader>fO", "<cmd>Telescope vim_options<cr>" },
    { "<leader>fr", "<cmd>Telescope resume<cr>" },
    { "<leader>fs", "<cmd>Telescope persisted<cr>", desc = "persited sessions" },
    { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "projects" },
    { "<leader>f?", "<cmd>Telescope search_history<cr>", desc = "search history" },
    { "<leader>f;", "<cmd>Telescope command_history<cr>", desc = "command-line history" },
    { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "execute command" },
  },
}

function M.config()
  local status_ok, telescope = pcall(require, "telescope")
  local icons = require("config.ui.icons")
  if not status_ok then
    return
  end

  local actions = require("telescope.actions")

  telescope.setup({
    defaults = {

      prompt_prefix = icons.ui.Telescope,
      selection_caret = " ",
      path_display = { "smart" },
      file_ignore_patterns = { "classes", "CVS" },

      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,

          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,

          ["<C-c>"] = actions.close,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,

          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["<C-l>"] = actions.complete_tag,
          ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
        },

        n = {
          ["<esc>"] = actions.close,
          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["H"] = actions.move_to_top,
          ["M"] = actions.move_to_middle,
          ["L"] = actions.move_to_bottom,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["gg"] = actions.move_to_top,
          ["G"] = actions.move_to_bottom,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["?"] = actions.which_key,
        },
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({}),
      },
    },
  })

  require("telescope").load_extension("projects")
end

return M
