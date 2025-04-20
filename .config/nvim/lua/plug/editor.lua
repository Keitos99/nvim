local icons = require("config.ui.icons")
local icons_todo = icons.todo
return {
  -- HACK: not sure why, but telescope-fzf-native will not be installed if it is defined as dependency of telescope
  {
    -- If encountering errors, see telescope-fzf-native README for install instructions
    "nvim-telescope/telescope-fzf-native.nvim",

    -- `build` is used to run some command when the plugin is installed/updated.
    -- This is only run then, not every time Neovim starts up.
    build = "make",

    -- `cond` is a condition used to determine whether this plugin should be
    -- installed and loaded.
    cond = function() return vim.fn.executable("make") == 1 end,
  },
  {
    -- Fuzzy finder
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x", -- release branch, which can have breaking changes
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    event = "VeryLazy",
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
      { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "projects" },
      { "<leader>f?", "<cmd>Telescope search_history<cr>", desc = "search history" },
      { "<leader>f;", "<cmd>Telescope command_history<cr>", desc = "command-line history" },
      { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "execute command" },
    },
    config = function()
      local telescope = require("telescope")

      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {

          prompt_prefix = icons.Telescope,
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
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("ui-select")
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader>d"] = { name = "+debug" },
        ["<leader>f"] = { name = "+find" },
        ["<leader>r"] = { name = "+rename" },
      },
    },
  },
  {
    -- for automatically highlighting other uses of the word under the cursor,
    -- using either LSP, Tree-sitter, or regex matching.
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },

    config = function()
      local illuminate = require("illuminate")
      -- <A-n> and <A-p> for moving between references
      -- <A-i> for as a textopbject under the cursor TODO: no plan what that means

      illuminate.configure({
        -- providers: provider used to get references in the buffer, ordered by priority
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
        delay = 100, -- delay in milliseconds
        filetype_overrides = {
          -- HACK: disabling treesitter provider because on "big" files it seems to slow down the scrolling. Is this a bug?
          ["java"] = {
            providers = {
              "lsp",
              "regex",
            },
          },
          -- HACK: ignore querys, because it slows down the navigation
          ["query"] = { providers = {} },
        },
        filetypes_denylist = {
          "dirvish",
          "fugitive",
          "NvimTree",
        },
        under_cursor = true,
        large_file_cutoff = nil,
        large_file_overrides = nil,
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "TodoTelescope" },
    event = "VeryLazy",
    keys = {
      {
        "]t",
        function() require("todo-comments").jump_next() end,
        desc = "Jump to the next todo comment",
      },
      {
        "[t",
        function() require("todo-comments").jump_prev() end,
        desc = "Jump to the previous todo comment",
      },
    },
    opts = {
      signs = true, -- show icons in the signs column
      sign_priority = 8, -- sign priority
      -- keywords recognized as todo comments
      keywords = {
        TODO = { icon = icons_todo.TODO, color = "info", alt = { "todo" } },
        FIX = { icon = icons_todo.FIX, color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        HACK = { icon = icons_todo.HACK, color = "warning" },
        PERF = { icon = icons_todo.PERF, alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        WARN = { icon = icons_todo.WARN, color = "warning", alt = { "WARNING", "XXX" } },
        NOTE = { icon = icons_todo.NOTE, color = "hint", alt = { "INFO" } },
        TEST = { icon = icons_todo.TEST, color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      highlight = {
        multiline = false,
        keyword = "bg",
        after = "fg",
        pattern = { [[.*<(KEYWORDS)\s*:]] },
      },
    },
  },
  {
    "monaqa/dial.nvim", -- better increase/descrease
    keys = {
      {
        "<C-a>",
        function() return require("dial.map").inc_normal() end,
        expr = true,
      },
      {
        "<C-x>",
        function() return require("dial.map").dec_normal() end,
        expr = true,
      },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%d.%m.%Y"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
        },
      })
    end,
  },
}
