return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  opts = {
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 500,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = ", <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    max_file_length = 40000, -- Disable if file is longer than this (in lines)

    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then return "]c" end
        vim.schedule(function() gs.next_hunk() end)
        return "<Ignore>"
      end, { expr = true })

      map("n", "[c", function()
        if vim.wo.diff then return "[c" end
        vim.schedule(function() gs.prev_hunk() end)
        return "<Ignore>"
      end, { expr = true })

      -- Actions
      map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
      map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
      map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
      map(
        "v",
        "<leader>gs",
        function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
        { desc = "Stage slected hunk" }
      )
      map(
        "v",
        "<leader>gr",
        function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
        { desc = "Reset selected hunk" }
      )
      map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
      map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
      map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
      map("n", "<leader>gB", gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
      map("n", "<leader>gbb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })
      map("n", "<leader>gd", gs.toggle_deleted, { desc = "Toggle deleted" })

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
    end,
  },
}
